#! /bin/bash
#
#Use storage class ocs-storagecluster-ceph-rbd when running on CoC PoT clusters
#mq00 reserved for instructor
#
# Set script variables
#
source setup.properties
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2) 
yellow=$(tput setaf 3) 
bold=$(tput bold)
normal=$(tput sgr0)
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
#
# Set all common variables
#
export IBM_MQ_LICENSE=$IBM_MQ_LICENSE
export IBM_MQ_VERSION=$IBM_MQ_VERSION
export TARGET_NAMESPACE=$NS
export QMpre="mq"$STUDENT_NUM
export VERSION=$IBM_MQ_VERSION
export LICENSE=$IBM_MQ_LICENSE
export SC=ocs-storagecluster-ceph-rbd
#export SC=ibmc-file-gold-gid
#
# Build the StreamQ build yaml script.
#
echo "..."
echo "[INFO] Build the ${bold}deployment yamls and test scripts for streamQ labs. ${normal} "

export QMInstance=$TARGET_NAMESPACE"-"$QMpre"strm"
export QMname="mq"$STUDENT_NUM"strm"
export ROUTE="mq"$STUDENT_NUM"strmchl.chl.mq.ibm.com"
export CHLCAPS="MQ"$STUDENT_NUM"STRMCHL"
export CHANNEL="mq"$STUDENT_NUM"strmchl"
export STREAMQ_DIR="streamq/deploy/"

( echo 'cat <<EOF' ; cat template/strm-install.sh_template ; echo EOF ) | sh > $STREAMQ_DIR"strm-install.sh"

chmod +x $STREAMQ_DIR"strm-install.sh"

echo "[INFO] StreamQ build yaml script is complete."
#
# Build the nativeHA build yaml script.
#
echo "...."
echo "[INFO] Build the ${bold}deployment yamls and test scripts for navtiveHA labs. ${normal} "

export QMname="mq"$STUDENT_NUM"ha"
export QMInstance=$TARGET_NAMESPACE"-"$QMname
export CHANNEL="mq"$STUDENT_NUM"hachl"
export CHLCAPS="MQ"$STUDENT_NUM"HACHL"
export HA_DIR="nativeha/deploy/"

( echo 'cat <<EOF' ; cat template/nativeha-install.sh_template ; echo EOF ) | sh > $HA_DIR"ha-install.sh"

chmod +x $HA_DIR"ha-install.sh"

echo "[INFO] nativeHA build yaml script is complete."
#
# Build the UniCluster build yaml scripts.
#
echo "...."
echo "[INFO] Build the ${bold}deployment yamls and test scripts for unicluster labs. ${normal} "

export QMInstancea=$TARGET_NAMESPACE"-mq"$STUDENT_NUM"a"
export QMnamea="mq"$STUDENT_NUM"a"
export CONNAMEa=$NS"-mq"$STUDENT_NUM"a-ibm-mq"
export SERVICEa="mq"$STUDENT_NUM"a-ibm-mq"
export CHANNELa="mq"$STUDENT_NUM"chla"
export TOCLUSa="TO_UNICLUS_mq"$STUDENT_NUM"a"

export QMInstanceb=$TARGET_NAMESPACE"-mq"$STUDENT_NUM"b"
export QMnameb="mq"$STUDENT_NUM"b"
export CONNAMEb=$NS"-mq"$STUDENT_NUM"b-ibm-mq"
export SERVICEb="mq"$STUDENT_NUM"b-ibm-mq"
export CHANNELb="mq"$STUDENT_NUM"chlb"
export TOCLUSb="TO_UNICLUS_mq"$STUDENT_NUM"b"

export QMInstancec=$TARGET_NAMESPACE"-mq"$STUDENT_NUM"c"
export QMnamec="mq"$STUDENT_NUM"c"
export CONNAMEc=$NS"-mq"$STUDENT_NUM"c-ibm-mq"
export SERVICEc="mq"$STUDENT_NUM"c-ibm-mq"
export CHANNELc="mq"$STUDENT_NUM"chlc"
export TOCLUSc="TO_UNICLUS_mq"$STUDENT_NUM"c"

export QMInstanced=$TARGET_NAMESPACE"-mq"$STUDENT_NUM"d"
export QMnamed="mq"$STUDENT_NUM"d"
export CONNAMEd="mq"$STUDENT_NUM"d-ibm-mq"
export SERVICEd="mq"$STUDENT_NUM"d-ibm-mq"
export CHANNELd="mq"$STUDENT_NUM"chld"
export TOCLUSd="TO_UNICLUS_mq"$STUDENT_NUM"d"

export UNICLUS=UNICLUS"$STUDENT_NUM"

export UNICLUSTER_DIR="unicluster/deploy/"
( echo 'cat <<EOF' ; cat template/uni-install.sh_template ; echo EOF ) | sh > $UNICLUSTER_DIR"uni-install.sh" 
chmod +x $UNICLUSTER_DIR"uni-install.sh"

( echo 'cat <<EOF' ; cat template/uni-addqmgr.sh_template ; echo EOF ) | sh > $UNICLUSTER_DIR"uni-addqmgr.sh"  
chmod +x $UNICLUSTER_DIR"uni-addqmgr.sh"

echo "[INFO] unicluster build yaml scripts is complete."




