#!/bin/bash

export APPQ=APPQ
export MQCHLLIB='/home/ibmuser/MQonCP4I/unicluster/test'
export MQCHLTAB='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQAPPLNAME='MY.PUTTER.APP'
export MQCCDTURL='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQSSLKEYR='/home/ibmuser/MQonCP4I/unicluster/test/key'
CCDT_NAME=${2:-"*ANY_QM"}
echo "Starting amqsphac" $CCDT_NAME
/opt/mqm/samp/bin/amqsphac APPQ $CCDT_NAME
