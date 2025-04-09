#! /bin/bash
#
# This script will get the host name for the Live cluster and will patch the recovery Cluster 
# to connect to the Live cluster.
#

source ../../setup.properties

export QMInstance=$1

# Logon to the active cluster
#oc login https://api.67c20883d1ee7bb0b5beada0.am1.techzone.ibm.com:6443 -u student8 -p welcometoFSMpot
oc login $OCP_CLUSTER1 -u $OCP_CLUSTER_USER -p $OCP_CLUSTER_PASSWORD > /dev/null 2>&1

export HOST=$(oc get route $QMInstance-ibm-mq-nhacrr -o jsonpath='{.spec.host}')
 
( echo "cat <<EOF" ; cat 4-recovery-enable-crr-template.yaml ; echo EOF ) | sh > 4-recovery-enable-crr.yaml

oc login $OCP_CLUSTER2 -u $OCP_CLUSTER_USER -p $OCP_CLUSTER_PASSWORD > /dev/null 2>&1

oc patch QueueManager $QMInstance --type merge --patch "$(cat 4-recovery-enable-crr.yaml)"
