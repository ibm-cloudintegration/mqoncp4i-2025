#!/bin/bash

#nativeha reserved for instructor
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export MQCCDTURL="${DIR}/ccdt_generated_recovery.json"
export MQSSLKEYR="${DIR}/key"
export MQCHLLIB="${DIR}"
export MQCHLTAB="${DIR}/ccdt_generated_recovery.json"
export TARGET_NAMESPACE=student2
export QMpre=mq02ha
export QMname=mq02ha
export CHLCAPS=NATIVEHACHL
export APPQ=APPQ1

# sendMessage.sh generated the json already.....
#export HOST="$(oc get route $QMname-ibm-mq-qm -n $TARGET_NAMESPACE -o jsonpath='{.spec.host}')"
#( echo "cat <<EOF" ; cat ccdt_template.json ; echo EOF ) | sh > ccdt_generated_recovery.json

echo "Starting /opt/mqm/samp/bin/amqsputc" $QMname
/opt/mqm/samp/bin/amqsputc $APPQ $QMname
