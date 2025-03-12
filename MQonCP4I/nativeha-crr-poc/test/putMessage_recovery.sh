#!/bin/bash

#nativeha reserved for instructor
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export MQCCDTURL="${DIR}/ccdt_generated_recovery.json"
echo $MQCCDTURL
export MQSSLKEYR="${DIR}/key"
#export MQCHLLIB="${DIR}"
#export MQCHLTAB="${DIR}/ccdt_generated_recovery.json"
export TARGET_NAMESPACE=student2
export QMpre=nativeha
export QMname=nativeha
export CHLCAPS=NATIVEHACHL
export APPQ=APPQ

### uncomment if needed - generate once #####
#export HOST="$(oc get route $QMname-ibm-mq-qm -n $TARGET_NAMESPACE -o jsonpath='{.spec.host}')"
#( echo "cat <<EOF" ; cat ccdt_template.json ; echo EOF ) | sh > ccdt_generated_recovery.json

echo "Starting amqsphac" $QMname
/opt/mqm/samp/bin/amqsphac $APPQ $QMname
