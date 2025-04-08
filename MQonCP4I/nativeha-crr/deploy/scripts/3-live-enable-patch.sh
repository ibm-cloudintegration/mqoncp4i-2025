#! /bin/bash
#Use storage class ibmc-file-gold-gid when running on ROKS clusters
#Use storage class managed-nfs-storage when running on CoC PoT clusters
#mq00 reserved for instructor

source ../../setup.properties

export QMInstance=$1

# Logon to the active cluster
#oc login https://api.67c20883d1ee7bb0b5beada0.am1.techzone.ibm.com:6443 -u student8 -p welcometoFSMpot
oc login $OCP_CLUSTER1 -u $OCP_CLUSTER_USER -p $OCP_CLUSTER_PASSWORD

##( echo "cat <<EOF" ; cat 3-live-enable-crr-template.yaml ; echo EOF ) | sh > 3-live-enable-crr.yaml

oc patch QueueManager $QMInstance --type merge --patch "$(cat 3-live-enable-crr.yaml)"
