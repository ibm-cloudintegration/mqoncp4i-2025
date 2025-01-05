#!/bin/bash
#
# This script will create the requied build scripts for all MQ labs 
#
ERRORMSG1="Error invalid arg:  \n\n
Usage: $0 -i 01 -n student1 \n
    -i, Student number \n
    -n, Student Namespace"

ERRORMSG2="Missing args:  \n\n
Usage: $0 -i 01 -n student1 \n
    -i, Student number \n
    -n, Student Namespace"

   while getopts ':i:n:' flag;
     do
       case "${flag}" in
         i) student=${OPTARG}
                printf -v STUDENT_NUM "%02d" $student; 
           	echo $STUDENT_NUM
	      ;;
         n) NS=${OPTARG};;
         *) echo -e ${ERRORMSG1}
		exit 1;;
       esac
   done
if [ $OPTIND -ne 5 ]; then
   echo -e ${ERRORMSG2} 
   exit 1
fi
#
# make sure you pass valid args
#
echo " You have set the Namespace to $NS and the instance number to $STUDENT_NUM"	 
 while true; do
   read -p "${bold}Are these correct?  The instance number is zero filled for numbers 1-9. (Y/N)${textreset}" yn
   case $yn in
       [Yy]* ) break;;
       [Nn]* ) exit 1;;
       * ) echo "Please answer y or n.";;
   esac
 done
 

export QMnamea="mq"$STUDENT_NUM"a"
export QMnameb="mq"$STUDENT_NUM"b"
export QMnamec="mq"$STUDENT_NUM"c"

export CHANNELA="MQ"$STUDENT_NUM"CHLA"    
export CHANNELB="MQ"$STUDENT_NUM"CHLB"
export CHANNELC="MQ"$STUDENT_NUM"CHLC"
export CHANNELD="MQ"$STUDENT_NUM"CHLD"

export CONNAMEa=$NS"-mq"$STUDENT_NUM"a-ibm-mq"
export CONNAMEb=$NS"-mq"$STUDENT_NUM"b-ibm-mq"
export CONNAMEc=$NS"-mq"$STUDENT_NUM"c-ibm-mq"
export CONNAMEd=$NS"-mq"$STUDENT_NUM"d-ibm-mq"
#
export HOSTa=$(oc get route $CONNAMEa"-qm" -n $NS -o jsonpath='{.spec.host}')
echo "host = $HOSTa"
export HOSTb=$(oc get route $CONNAMEb"-qm" -n $NS -o jsonpath='{.spec.host}')
export HOSTc=$(oc get route $CONNAMEc"-qm" -n $NS -o jsonpath='{.spec.host}')

( echo 'cat <<EOF' ; cat ccdt.json_template ; echo EOF ) | sh > ccdt.json 
exit
( echo 'cat <<EOF' ; cat template/uni-install.sh_template ; echo EOF ) | sh > $UNICLUSTER_DIR"uni-install.sh" 



