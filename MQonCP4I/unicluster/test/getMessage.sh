#!/bin/bash

export APPQ=APPQ
export MQCHLLIB='/home/ibmuser/MQonCP4I/unicluster/test'
export MQCHLTAB='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQAPPLNAME='MY.GETTER.APP'
export MQCCDTURL='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQSSLKEYR='/home/ibmuser/MQonCP4I/unicluster/test/key'
CCDT_NAME=${2:-"*ANY_QM"}
echo "Starting amqsghac" $CCDT_NAME
/opt/mqm/samp/bin/amqsghac APPQ $CCDT_NAME
