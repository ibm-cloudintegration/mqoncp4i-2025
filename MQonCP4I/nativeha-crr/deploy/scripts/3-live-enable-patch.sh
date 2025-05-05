#! /bin/bash
#
# This script will get the host name for the Recovery cluster and will patch the live Cluster 
# to connect to the Recovery cluster.
#
source ../../setup.properties
export QMInstance=$1

# Logon to the Recovery cluster to get the HOST name 
#oc login https://api.67c20883d1ee7bb0b5beada0.am1.techzone.ibm.com:6443 -u student8 -p welcometoFSMpot
oc login $OCP_CLUSTER2 -u $OCP_CLUSTER_USER2 -p $OCP_CLUSTER_PASSWORD2 > /dev/null 2>&1

export HOST=$(oc get route $QMInstance-ibm-mq-nhacrr -o jsonpath='{.spec.host}')

( echo "cat <<EOF" ; cat 3-live-enable-crr-template.yaml ; echo EOF ) | sh > 3-live-enable-crr.yaml

oc login $OCP_CLUSTER1 -u $OCP_CLUSTER_USER1 -p $OCP_CLUSTER_PASSWORD1
oc patch QueueManager $QMInstance --type merge --patch "$(cat 3-live-enable-crr.yaml)"
