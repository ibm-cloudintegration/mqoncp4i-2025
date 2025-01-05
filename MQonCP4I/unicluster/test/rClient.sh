#!/bin/bash

export QMpre=mq01
export QMname=mq01a

export MQCHLLIB='/home/ibmuser/MQonCP4I/unicluster/test'
export MQCHLTAB='/home/ibmuser/MQonCP4I/unicluster/test/ccdt4.json'
export MQAPPLNAME='MY.GETTER.APP'
export MQCCDTURL='/home/ibmuser/MQonCP4I/unicluster/test/ccdt4.json'
export MQSSLKEYR='/home/ibmuser/MQonCP4I/unicluster/test/key'


CCDT_NAME=${2:-"*ANY_QM"}

for (( i=0; i<=5; ++i)); do
  echo "Starting amqsghac" $CCDT_NAME
  /opt/mqm/samp/bin/amqsghac APPQ $CCDT_NAME &
done
