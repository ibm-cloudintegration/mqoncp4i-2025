#! /bin/bash
#
# This script will pass the QMgr name for the Live cluster (CLUSTER 1) to switch CRR Role
#
source ../../setup.properties

export QMInstance=$1

# Logon to the active cluster
#oc login https://api.67c20883d1ee7bb0b5beada0.am1.techzone.ibm.com:6443 -u student8 -p welcometoFSMpot
oc login $OCP_CLUSTER1 -u $OCP_CLUSTER_USER1 -p $OCP_CLUSTER_PASSWORD1 > /dev/null 2>&1

oc patch QueueManager $QMInstance --type merge --patch "$(cat 5-switch-roles.yaml)"
