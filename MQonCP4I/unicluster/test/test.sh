#!/bin/bash

for i in mq01a mq01b mq01c
do
gnome-terminal --title="Window $i" --profile="test" -- $HOME/MQonCP4I/unicluster/test/showConns.sh $i
##gnome-terminal -- $HOME/MQonCP4I/unicluster/test/showConns.sh $i 
##./showConns.sh mq01a
done
exit



xterm -title node1 -hold -e 'bash -c "read; echo REPLY=\$REPLY"' &
sleep 1

xdotool windowfocus --sync $(xdotool search --name node1) # set focus on xterm with title `node1`
xdotool type "Hello, World!"
xdotool key Return
exit

gnome-terminal -- bash -c "cd; ls  " &
exit

gnome-terminal -- bash -c "ls; read -n 1"

konsole --noclose -e echo Hello terminal 1! &
konsole --noclose -e echo Hello terminal 2! &
konsole --noclose -e echo Hello terminal 3! &
konsole --noclose -e echo Hello terminal 4! &
exit
export QMpre=mq00
export QMname=mq00a
export APPQ=APPQ
export MQCHLLIB='/home/student/MQonCP4I/unicluster/test'
export MQCHLTAB='/home/student/MQonCP4I/unicluster/test/ccdt.json'
export MQAPPLNAME='MY.GETTER.APP'
export MQCCDTURL='/home/student/MQonCP4I/unicluster/test/ccdt.json'
export MQSSLKEYR='/home/student/MQonCP4I/unicluster/test/key'

echo "Starting amqsghac" $QMname
/opt/mqm/samp/bin/amqsghac $APPQ $QMname
