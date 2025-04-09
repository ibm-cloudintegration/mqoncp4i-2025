#! /bin/bash
#
# This script will check the Role of each cluster and then switch them for controlled failover 
#
source ../../setup.properties

export HA_DIR_DEPLOY="nativeha-crr/deploy"
export TARGET_NAMESPACE=$2
export QMname=$1
##oc project $TARGET_NAMESPACE
####
##    NOTE:  Make sure to logon to the recovery openshift cluster
####
# Logon to the Live Cluster
echo "Logon to OpenShift Cluster 1" 
oc login ${OCP_CLUSTER1} -u ${OCP_CLUSTER_USER} -p ${OCP_CLUSTER_PASSWORD} > /dev/null 2>&1

export CURRENT_ROLE=$(oc get QueueManager $QMInstance -o jsonpath='{.spec.queueManager.availability.nativeHAGroups.local.role}')
echo "Cluster 1 - Role is: " $CURRENT_ROLE

if [[ "$CURRENT_ROLE" == "Recovery" ]]; then
   export ROLE="Live"
else
   export ROLE="Recovery"
fi   
( echo "cat <<EOF" ; cat 5-switch-roles-template.yaml ; echo EOF ) | sh > 5-switch-roles.yaml
echo "switch cluster 1"
echo "Switching Role on Cluster 1 from " $CURRENT_ROLE to $ROLE
./scripts/5-live-switch-patch.sh $QMname

echo ""
# Logon to the Recovery cluster
echo "Logon to OpenShift Cluster 2" 
oc login ${OCP_CLUSTER2} -u ${OCP_CLUSTER_USER} -p ${OCP_CLUSTER_PASSWORD} > /dev/null 2>&1

export CURRENT_ROLE=$(oc get QueueManager $QMInstance -o jsonpath='{.spec.queueManager.availability.nativeHAGroups.local.role}')
echo "Cluster 2 - Role is: " $CURRENT_ROLE

if [[ "$CURRENT_ROLE" == "Recovery" ]]; then
   export ROLE="Live"
else
   export ROLE="Recovery"
fi   
( echo "cat <<EOF" ; cat 5-switch-roles-template.yaml ; echo EOF ) | sh > 5-switch-roles.yaml
echo "switch cluster 2"
echo "Switching Role on Cluster 2 from " $CURRENT_ROLE to $ROLE

./scripts/5-recovery-switch-patch.sh $QMname
echo "done."
