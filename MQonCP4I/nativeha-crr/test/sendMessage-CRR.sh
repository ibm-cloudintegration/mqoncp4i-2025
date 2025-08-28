#!/bin/bash

source ../../setup.properties
#mq00 reserved for instructor
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export MQCCDTURL="${DIR}/ccdt_CRR_generated.json"
export MQSSLKEYR="${DIR}/key"
export MQCHLLIB="${DIR}"
export MQCHLTAB="${DIR}/ccdt_CRR_generated.json"
export TARGET_NAMESPACE=$1
export QMpre=$2
export QMname=$3
export CHLCAPS=$4
export APPQ=$5

oc login $OCP_CLUSTER1 -u $OCP_CLUSTER_USER1 -p $OCP_CLUSTER_PASSWORD1 > /dev/null 2>&1
oc project $TARGET_NAMESPACE
export HOST1="$(oc get route $TARGET_NAMESPACE-$QMname-ibm-mq-qm -n $TARGET_NAMESPACE -o jsonpath='{.spec.host}')"

oc login $OCP_CLUSTER2 -u $OCP_CLUSTER_USER2 -p $OCP_CLUSTER_PASSWORD2 > /dev/null 2>&1
oc project $TARGET_NAMESPACE
export HOST2="$(oc get route $TARGET_NAMESPACE-$QMname-ibm-mq-qm -n $TARGET_NAMESPACE -o jsonpath='{.spec.host}')"

(echo "cat <<EOF" ; cat ccdt_CRR_template.json ; echo EOF ) | sh > ccdt_CRR_generated.json

echo "Starting amqsphac" $QMname
/opt/mqm/samp/bin/amqsphac $APPQ $QMname