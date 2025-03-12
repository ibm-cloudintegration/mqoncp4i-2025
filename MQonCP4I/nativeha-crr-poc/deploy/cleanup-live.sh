oc login https://api.67c20883d1ee7bb0b5beada0.am1.techzone.ibm.com:6443 -u kubeadmin -p 64fZL-Q3gWc-fuWP6-IMDT8
oc project student2
oc project
oc delete queuemanager student2-mq02ha
oc delete pv  $(oc get pvc --no-headers | grep mq02ha | awk '{print$3}')
oc delete pvc $(oc get pvc --no-headers | grep mq02ha | awk '{print$1}')
oc delete route mq02ha-nativehachl-ibm-mq-qm 
oc delete secret mq02ha-qm-tls
