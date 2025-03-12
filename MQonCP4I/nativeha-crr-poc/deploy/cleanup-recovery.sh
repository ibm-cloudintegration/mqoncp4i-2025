oc login https://api.67c202f1d1ee7bb0b5bead95.am1.techzone.ibm.com:6443 -u kubeadmin -p p3RcB-7mmqN-2MtpA-Fj8WL
oc project student2
oc project
oc delete pv  $(oc get pvc --no-headers | grep mq02ha | awk '{print$3}')
oc delete pvc $(oc get pvc --no-headers | grep mq02ha | awk '{print$1}')
oc delete route mq02ha-nativehachl-ibm-mq-qm 
oc delete secret mq02ha-qm-tls
