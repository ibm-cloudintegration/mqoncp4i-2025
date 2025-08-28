#! /bin/bash
#
###############################################################################################
# Author: Joe Jodl
# Date Created: 8/25/2025
# Descripton: This script is used to clean up all access for student accounts after nativeHA
# lab sesion. 
###############################################################################################
#
source setup.properties
OC_PWD1=$1
OC_PWD2=$2
#
# Clean up Cluster 1 
#
oc login ${OCP_CLUSTER1} -u kubeadmin -p $OC_PWD1
MAX=21
for ((NS=1; NS<MAX; NS++ ));
  do
   length=${#NS}
   if [ $length -ne 2 ]; then
      STUDENT_NUM=$(printf "%02d" "$NS")
     else 
      STUDENT_NUM=$NS
   fi
   export QMname=mq${STUDENT_NUM}ha
   echo $QMname
   export TARGET_NAMESPACE=student$NS
    oc project ${TARGET_NAMESPACE} --no-headers > /dev/null 2>&1 
    
   oc delete queuemanager ${TARGET_NAMESPACE}-$QMname 
   oc delete configmap ${QMname}-mqsc
   oc delete route ${QMname}-${QMname}chl-ibm-mq-qm -n ${TARGET_NAMESPACE}
   oc delete pvc $(oc get pvc --no-headers | grep ${QMname} | awk '{print$1}')
   oc delete secret ${QMname}-qm-tls
done
#
# Clean up Cluster 2
#
oc login ${OCP_CLUSTER2} -u kubeadmin -p $OC_PWD2
MAX=21
for ((NS=1; NS<MAX; NS++ ));
  do
   length=${#NS}
   if [ $length -ne 2 ]; then
      STUDENT_NUM=$(printf "%02d" "$NS")
     else 
      STUDENT_NUM=$NS
   fi
   export QMname=mq${STUDENT_NUM}ha
   echo $QMname
   export TARGET_NAMESPACE=student$NS
    oc project ${TARGET_NAMESPACE} --no-headers > /dev/null 2>&1 
    
   oc delete queuemanager ${TARGET_NAMESPACE}-$QMname 
   oc delete configmap ${QMname}-mqsc
   oc delete route ${QMname}-${QMname}chl-ibm-mq-qm -n ${TARGET_NAMESPACE}
   oc delete pvc $(oc get pvc --no-headers | grep ${QMname} | awk '{print$1}')
   oc delete secret ${QMname}-qm-tls
done
