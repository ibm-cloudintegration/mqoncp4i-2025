#! /bin/bash
#
###############################################################################################
# Author: Joe Jodl
# Date Created: 1/25/2025
# Descripton: Set the Namespace in the properties file
###############################################################################################
#
export TARGET_NAMESPACE=$1
export STUDENT_NUM=$2
echo "[INFO] Generating setup.properties"
echo "[INFO] Update ${bold}setup.properties${normal} with your student number"

if [ $STUDENT_NUM -lt 11 ]; then
  export OCP_CLUSTER1="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
else
  export OCP_CLUSTER1="yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
fi
#
export OCP_CLUSTER2="zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
#
envsubst < setup.properties_template > setup.properties

#( echo 'cat <<EOF' ; cat setup.properties_template ; echo EOF ) | sh > setup.properties