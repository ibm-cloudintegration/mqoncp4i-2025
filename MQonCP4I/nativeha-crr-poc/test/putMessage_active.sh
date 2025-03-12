#!/bin/bash

#mq02ha reserved for instructor
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export MQCCDTURL="${DIR}/ccdt_generated_active.json"
echo $MQCCDTURL
export MQSSLKEYR="${DIR}/key"
#export MQCHLLIB="${DIR}"
#export MQCHLTAB="${DIR}/ccdt_generated_active.json"
export TARGET_NAMESPACE=student2
export QMpre=mq02ha
export QMname=mq02ha
export CHLCAPS=NATIVEHACHL
export APPQ=APPQ

### uncomment if needed - generate once #####

# Get active nhacrr route & host
#oc login https://api.67c20883d1ee7bb0b5beada0.am1.techzone.ibm.com:6443 -u student2 -p welcometoFSMpot

#export HOST="$(oc get route $TARGET_NAMESPACE-$QMname-ibm-mq-qm -n $TARGET_NAMESPACE -o jsonpath='{.spec.host}')"
echo $HOST

#( echo "cat <<EOF" ; cat ccdt_template.json ; echo EOF ) | sh > ccdt_generated_active.json

echo "Starting amqsphac" $QMname
/opt/mqm/samp/bin/amqsphac $APPQ $QMname
