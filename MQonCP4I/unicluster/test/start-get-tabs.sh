#!/bin/bash

##for (( i=1; i<7; ++i)); do
##gnome-terminal --title="Get Msg{$i}" -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh" 
##done
##exit

for (( i=1; i<7; ++i)); do
gnome-terminal --title="Get Msg{$i}" --tab -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh" 
done
