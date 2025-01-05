#!/bin/bash

for i in mq01a mq01b mq01c
do
gnome-terminal --title="Window $i" -- $HOME/MQonCP4I/unicluster/test/showConns.sh $i
##gnome-terminal -- $HOME/MQonCP4I/unicluster/test/showConns.sh $i 
##./showConns.sh mq01a
done
