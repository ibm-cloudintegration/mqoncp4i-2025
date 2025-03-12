#! /bin/bash


# pass qmgr name examnple student2-mq02ha
export QMname=$1
export TARGET_NAMESPACE=$2

oc project $TARGET_NAMESPACE

if [[ -z "${QMname// /}" ]]; then
  echo -e "Syntax error: $0 <qmgr-name> <target-namespace>. Example $0 mq02ha student2"
  exit 1
fi

if [[ -z "${TARGET_NAMESPACE// /}" ]]; then
  echo -e "Syntax error: $0 <qmgr-name> <target-namespace>. Example $0 mq02ha student2"
  exit 1
fi

oc login https://api.67c202f1d1ee7bb0b5bead95.am1.techzone.ibm.com:6443 -u student2 -p welcometoFSMpot
oc project $TARGET_NAMESPACE

export VERSION=9.4.2.0-r1
export LICENSE=L-QYVA-B365MB
export QMGR_NAME_LOWERCASE=$(echo $QMname | tr '[:upper:]' '[:lower:]')
## echo $QMGR_NAME_LOWERCASE
export CHANNEL=nativehachl
export CHLCAPS=NATIVEHACHL

#Use storage class ibmc-file-gold-gid when running on ROKS clusters
#Use storage class managed-nfs-storage when running on CoC PoT clusters
#export SC=managed-nfs-storage
#export SC=ibmc-file-gold-gid
#export SC=ibmc-block-gold
export SC=ocs-storagecluster-ceph-rbd

export QM_KEY=$(cat ./${QMGR_NAME_LOWERCASE}.key | base64 | tr -d '\n')
export QM_CERT=$(cat ./${QMGR_NAME_LOWERCASE}.crt | base64 | tr -d '\n')
export CA_CERT=$(cat ./ca.crt | base64 | tr -d '\n')

( echo "cat <<EOF" ; cat 2-recovery-template.yaml ; echo EOF ) | sh > x-2-recovery.yaml

oc apply -f x-2-recovery.yaml
