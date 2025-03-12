#!/bin/bash
##set -x

#nativeha reserved for instructor
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export MQCCDTURL="${DIR}/ccdt_generated.json"
export MQSSLKEYR="${DIR}/key"
export MQCHLLIB="${DIR}"
export MQCHLTAB="${DIR}/ccdt_generated.json"
export TARGET_NAMESPACE=student2
export QMpre=nativeha
export QMname=nativeha
export CHLCAPS=NATIVEHACHL
export APPQ=APPQ

# generated already #
#export HOST="$(oc get route $QMname-ibm-mq-qm -n $TARGET_NAMESPACE -o jsonpath='{.spec.host}')"
#( echo "cat <<EOF" ; cat ccdt_template.json ; echo EOF ) | sh > ccdt_generated.json

echo "Starting amqsghac" $QMname
/opt/mqm/samp/bin/amqsghac $APPQ $QMname
