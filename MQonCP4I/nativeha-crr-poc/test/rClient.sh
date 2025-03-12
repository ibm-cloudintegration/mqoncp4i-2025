#!/bin/bash

#export MQCHLLIB=/home/david/Tools
#export MQCHLTAB=ccdt.json
export MQCCDTURL='/Users/sbodapati/xibm_ts/sb_demos/mq/nativeha/test/generated_ccdt.json'

CCDT_NAME=${2:-"*ANY_QM"}
#CCDT_NAME=${2:-"unirdqm2"}

for (( i=0; i<$1; ++i)); do
  echo "Starting amqsghac"
  amqsghac APPQ $CCDT_NAME &
done
