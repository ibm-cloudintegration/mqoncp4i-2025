openssl genpkey -algorithm rsa -pkeyopt rsa_keygen_bits:4096 -out ca.key
openssl req -x509 -new -nodes -key ca.key -sha512 -days 365 -subj "/CN=pot-selfsigned-ca" -out ca.crt
 
openssl req -new -nodes -out pot-qm.csr -newkey rsa:4096 -keyout pot-qm.key -subj '/CN=pot-qm'
 
openssl x509 -req -in pot-qm.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out pot-qm.crt -days 365 -sha512
 
# *** Make sure to be logged into cluster ***
oc project student2

kubectl create secret generic pot-qm-tls --type="kubernetes.io/tls" --from-file=tls.key=pot-qm.key --from-file=tls.crt=pot-qm.crt --from-file=ca.crt
 
openssl req -new -nodes -out pot-app1.csr -newkey rsa:4096 -keyout pot-app1.key -subj '/CN=pot-app1'
 
openssl x509 -req -in pot-app1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out pot-app1.crt -days 365 -sha512

openssl pkcs12 -export -in "pot-app1.crt" -name "pot-app1" -certfile "ca.crt" -inkey "pot-app1.key" -out "pot-app1.p12" -passout pass:passw0rd
