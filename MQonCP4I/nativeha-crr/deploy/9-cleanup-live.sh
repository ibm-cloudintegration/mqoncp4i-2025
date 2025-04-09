source ../../setup.properties

export QMname=$1
export TARGET_NAMESPACE=$2

if [[ -z "${QMname// /}" ]]; then
  echo -e "Syntax error: $0 <qmgr-name> <target-namespace>. Example $0 mq02ha student8"
  exit 1
fi

if [[ -z "${TARGET_NAMESPACE// /}" ]]; then
  echo -e "Syntax error: $0 <qmgr-name> <target-namespace>. Example $0 mq02ha student8"
  exit 1
fi

oc login ${OCP_CLUSTER1} -u ${OCP_CLUSTER_USER} -p ${OCP_CLUSTER_PASSWORD}
oc project ${TARGET_NAMESPACE}
oc delete queuemanager ${TARGET_NAMESPACE}-$QMname 
oc delete configmap ${QMname}-mqsc
#oc delete pv  $(oc get pvc --no-headers | grep ${QMname} | awk '{print$3}')
oc delete pvc $(oc get pvc --no-headers | grep ${QMname} | awk '{print$1}')
oc delete secret ${QMname}-qm-tls
