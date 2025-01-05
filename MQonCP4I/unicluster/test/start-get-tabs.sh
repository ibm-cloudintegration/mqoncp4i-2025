#!/bin/bash

for (( i=1; i<7; ++i)); do
gnome-terminal --title="Get Msg{$i}" -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh" 
done
exit

gnome-terminal --tab --title="test2" -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh" 
gnome-terminal --tab --title="test3" -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh"


set -x 
gnome-terminal --title="get messages1" --profile="test" --tab --title="test1" -e "$HOME/MQonCP4I/unicluster/test/getMessage.sh" --tab --title="test2" -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh" --tab --title="test3" -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh"
exit
for (( i=0; i<7; ++i)); do
$HOME/MQonCP4I/unicluster/test/getMessage.sh
##gnome-terminal -- $HOME/MQonCP4I/unicluster/test/showConns.sh $i 
##./showConns.sh mq01a
done

exit 


gnome-terminal --title="Window Get" --profile="test" --tab -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh" --tab -- "top" --tab -- "$HOME/MQonCP4I/unicluster/test/getMessage.sh"
exit



##gnome-terminal -- bash -c 'ls;$HOME/MQonCP4I/unicluster/test/getMessage.sh&;echo test; sleep 10; exec bash'

gnome-terminal --title="Window Get" --profile="test" --tab -e "$HOME/MQonCP4I/unicluster/test/getMessage.sh" --tab -e "$HOME/MQonCP4I/unicluster/test/getMessage.sh"

exit 
gnome-terminal --title="Window Get" --profile="test" -- bash -c 'ls;$HOME/MQonCP4I/unicluster/test/getMessage.sh && $HOME/MQonCP4I/unicluster/test/getMessage.sh &; exec bash'

exit 


gnome-terminal --title="Window Get" --profile="test" -- '$HOME/MQonCP4I/unicluster/test/getMessage.sh &'; '$HOME/MQonCP4I/unicluster/test/getMessage.sh &' 
exit

gnome-terminal --title="Window Get" --profile="test" -- $HOME/MQonCP4I/unicluster/test/getMessage.sh $HOME/MQonCP4I/unicluster/test/getMessage.sh; $HOME/MQonCP4I/unicluster/test/getMessage.sh

for (( i=0; i<7; ++i)); do
$HOME/MQonCP4I/unicluster/test/getMessage.sh
##gnome-terminal -- $HOME/MQonCP4I/unicluster/test/showConns.sh $i 
##./showConns.sh mq01a
done


