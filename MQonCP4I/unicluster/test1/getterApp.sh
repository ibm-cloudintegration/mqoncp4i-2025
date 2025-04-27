#!/bin/bash
for i in mq01a mq01b mq01c
do
gnome-terminal --geometry=10x5 --title="Getter" -- /home/ibmuser/MQonCP4I/unicluster/test1/showConns.sh $i Getter
done
