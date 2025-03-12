#!/bin/bash

#nativeha reserved for instructor
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export MQCCDTURL="${DIR}/ccdt_generated.json"
export MQSSLKEYR="${DIR}/key"
export MQCHLLIB="${DIR}"
export MQCHLTAB="${DIR}/ccdt_generated.json"
export TARGET_NAMESPACE=cp4i-mq
export QMpre=nativeha
export QMname=nativeha
export CHLCAPS=NATIVEHACHL
export APPQ=APPQ1

# sendMessage.sh generated the json already.....
#export HOST="$(oc get route $QMname-ibm-mq-qm -n $TARGET_NAMESPACE -o jsonpath='{.spec.host}')"
#( echo "cat <<EOF" ; cat ccdt_template.json ; echo EOF ) | sh > ccdt_generated.json

echo "Starting /opt/mqm/samp/bin/amqsputc" $QMname
/opt/mqm/samp/bin/amqsputc $APPQ $QMname
