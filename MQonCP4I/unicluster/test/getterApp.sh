#!/bin/bash

for i in mq01a mq01b mq01c
do
gnome-terminal --title="Getter $i" -- $HOME/MQonCP4I/unicluster/test/showConns.sh $i
done
