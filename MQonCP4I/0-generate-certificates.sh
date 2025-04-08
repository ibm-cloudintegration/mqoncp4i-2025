#!/bin/bash

QMGR_NAME=$1

if [[ -z "${QMGR_NAME// /}" ]]; then
  echo -e "Syntax error: pass arguments, example: $0 mq02ha"
  exit 1
fi

export HA_DIR="nativeha-crr"

QMGR_NAME_LOWERCASE=${HA_DIR}/deploy/certs/$(echo $QMGR_NAME | tr '[:upper:]' '[:lower:]')
QMGR_KEY_FILENAME=${HA_DIR}/deploy/certs/${QMGR_NAME}.key
QMGR_CSR_FILENAME=${HA_DIR}/deploy/certs/${QMGR_NAME}.csr
QMGR_CERT_FILENAME=${HA_DIR}/deploy/certs/${QMGR_NAME}.crt
QMGR_PKCS_FILENAME=${HA_DIR}/deploy/certs/${QMGR_NAME}.p12
CA_KEY=${HA_DIR}/deploy/certs/$QMGR_NAME-ca.key
CA_CRT=${HA_DIR}/deploy/certs/$QMGR_NAME-ca.crt
PASSWORD=passw0rd

rm $CA_KEY $CA_CRT $QMGR_KEY_FILENAME $QMGR_CSR_FILENAME $QMGR_CERT_FILENAME $QMGR_PKCS_FILENAME ${QMGR_NAME_LOWERCASE}.jks   > /dev/null 2>&1 

# Generate self signed CA
openssl genpkey -algorithm rsa -pkeyopt rsa_keygen_bits:4096 -out ${CA_KEY}
 
openssl req -x509 -new -nodes -key ${CA_KEY} -sha512 -days 365 -subj "/CN=selfsigned-ca" -out ${CA_CRT}
 
# Queue Manager Certificate
SUBJECT="/CN=${QMGR_NAME}-qm"
echo $SUBJECT
openssl req -new -nodes -out ${QMGR_CSR_FILENAME} -newkey rsa:4096 -keyout ${QMGR_KEY_FILENAME} -subj ${SUBJECT}

openssl x509 -req -in ${QMGR_CSR_FILENAME} -CA ${CA_CRT}  -CAkey ${CA_KEY} -CAcreateserial -out ${QMGR_CERT_FILENAME} -days 365 -sha512
 
# Secret is created in the yaml file
### kubectl create secret generic ${QMGR_NAME_LOWERCASE}-qm-tls --type="kubernetes.io/tls" --from-file=tls.key=certs/${QMGR_KEY_FILENAME}.key --from-file=tls.crt=certs/${QMGR_CERT_FILENAME} --from-file=certs/$QMGR_NAME-ca.crt

# Add the key and certificate to a PKCS #12 key store, for the server to use
openssl pkcs12 \
       -inkey ${QMGR_KEY_FILENAME} \
       -in ${QMGR_CERT_FILENAME} \
       -export -out ${QMGR_PKCS_FILENAME} \
       -password pass:${PASSWORD}

# Add the certificate to a trust store in JKS format, for Java clients to use when connecting
keytool -importkeystore -srckeystore ${QMGR_PKCS_FILENAME} \
        -srcstoretype PKCS12 \
        -destkeystore ${QMGR_NAME_LOWERCASE}.jks \
        -deststoretype JKS \
	-srcstorepass ${PASSWORD}  \
	-deststorepass ${PASSWORD} \
	-noprompt
