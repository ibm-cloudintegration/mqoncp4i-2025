#!/bin/bash

export QMpre=mq01
export QMname=mq01a
export APPQ=APPQ
export MQCHLLIB='/home/ibmuser/MQonCP4I/unicluster/test'
export MQCHLTAB='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQAPPLNAME='MY.PUTTER.APP'
export MQCCDTURL='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQSSLKEYR='/home/ibmuser/MQonCP4I/unicluster/test/key'

echo "Starting amqsphac" $QMname
/opt/mqm/samp/bin/amqsphac $APPQ $QMname
