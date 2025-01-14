#!/bin/bash

clear
green='\033[0;32m'
lgreen='\033[1;32m'
yellow='\033[0;33m'
nc='\033[0m'

if [ $2 == "Getter" ]
 then
   export MQAPPLNAME='MY.GETTER.APP'
   export APPNAME=amqsghac
   export COLOR=$green
 else 
   export MQAPPLNAME='MY.PUTTER.APP'
   export APPNAME=amqsphac
  export COLOR=$yellow
fi 

export APPQ=APPQ
export MQCHLLIB='/home/ibmuser/MQonCP4I/unicluster/test'
export MQCHLTAB='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQCCDTURL='/home/ibmuser/MQonCP4I/unicluster/test/ccdt.json'
export MQSSLKEYR='/home/ibmuser/MQonCP4I/unicluster/test/key'

DELAY=${3:-1s}

for (( i=0; i<100000; ++i)); do
  CONNCOUNT=`echo "dis conn(*) where(appltag eq '$MQAPPLNAME')" | runmqsc -c $1 | grep "  CONN" | wc -w`
  BALANCED=`echo "dis apstatus('$MQAPPLNAME')" | runmqsc $1 | grep "  BALANCED"`
  clear
    echo -e "${COLOR}$1${nc} / ${COLOR}$MQAPPLNAME${nc} -- ${COLOR}$CONNCOUNT${nc}"
    echo "dis conn(*) where(appltag eq '$MQAPPLNAME')" | runmqsc $1 | grep "  CONN"
  sleep $DELAY
done




