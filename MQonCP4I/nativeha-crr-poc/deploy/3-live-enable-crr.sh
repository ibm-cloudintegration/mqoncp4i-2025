####
##    NOTE:  Make sure to logon to the recovery openshift cluster
####


export QMGR_NAME=$1
export TARGET_NAMESPACE=$2

if [[ -z "${QMGR_NAME// /}" ]]; then
  echo -e "Syntax error: $0 <qmgr-name> <namespace>. Example $0 mq02ha student2"
  exit 1
fi

if [[ -z "${TARGET_NAMESPACE// /}" ]]; then
  echo -e "Syntax error: $0 <qmgr-name> <namespace>. Example $0 mq02ha student2"
  exit 1
fi

# Get Recovery nhacrr route & host
oc login https://api.67c202f1d1ee7bb0b5bead95.am1.techzone.ibm.com:6443 -u student2 -p welcometoFSMpot

export HOST=$(oc get route $TARGET_NAMESPACE-$QMGR_NAME-ibm-mq-nhacrr -o jsonpath='{.spec.host}')

( echo "cat <<EOF" ; cat 3-live-enable-crr-template.yaml ; echo EOF ) | sh > x-3-live-enable-crr.yaml

# Logon to the active cluster
oc login https://api.67c20883d1ee7bb0b5beada0.am1.techzone.ibm.com:6443 -u student2 -p welcometoFSMpot

oc patch QueueManager $TARGET_NAMESPACE-$QMGR_NAME --type merge --patch "$(cat x-3-live-enable-crr.yaml)"
