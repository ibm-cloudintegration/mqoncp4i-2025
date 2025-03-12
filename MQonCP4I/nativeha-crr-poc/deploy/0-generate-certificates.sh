#!/bin/bash

QMGR_NAME=$1

if [[ -z "${QMGR_NAME// /}" ]]; then
  echo -e "Syntax error: pass arguments, example: $0 mq02ha"
  exit 1
fi

QMGR_NAME_LOWERCASE=$(echo $QMGR_NAME | tr '[:upper:]' '[:lower:]')
QMGR_KEY_FILENAME=${QMGR_NAME}.key
QMGR_CSR_FILENAME=${QMGR_NAME}.csr
QMGR_CERT_FILENAME=${QMGR_NAME}.crt
QMGR_PKCS_FILENAME=${QMGR_NAME}.p12
PASSWORD=passw0rd

rm ca.key ca.crt $QMGR_KEY_FILENAME $QMGR_CSR_FILENAME $QMGR_CERT_FILENAME $QMGR_PKCS_FILENAME ${QMGR_NAME_LOWERCASE}.jks

# Generate self signed CA
openssl genpkey -algorithm rsa -pkeyopt rsa_keygen_bits:4096 -out ca.key
 
openssl req -x509 -new -nodes -key ca.key -sha512 -days 365 -subj "/CN=selfsigned-ca" -out ca.crt
 
# Queue Manager Certificate
SUBJECT="/CN=${QMGR_NAME}-qm"
echo $SUBJECT
openssl req -new -nodes -out ${QMGR_CSR_FILENAME} -newkey rsa:4096 -keyout ${QMGR_KEY_FILENAME} -subj ${SUBJECT}

openssl x509 -req -in ${QMGR_CSR_FILENAME} -CA ca.crt -CAkey ca.key -CAcreateserial -out ${QMGR_CERT_FILENAME} -days 365 -sha512
 
# Secret is created in the yaml file
### kubectl create secret generic ${QMGR_NAME_LOWERCASE}-qm-tls --type="kubernetes.io/tls" --from-file=tls.key=${QMGR_KEY_FILENAME}.key --from-file=tls.crt=${QMGR_CERT_FILENAME} --from-file=ca.crt


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

# create kdb file
rm ../test/key.*
runmqakm -keydb -create -db ../test/key.kdb -type cms -pw passw0rd -stash
runmqakm -cert -add -db ../test/key.kdb -pw passw0rd -label ca -file ca.crt
runmqakm -cert -add -db ../test/key.kdb -pw passw0rd -label $QMGR_NAME_LOWERCASE -file $QMGR_CERT_FILENAME
