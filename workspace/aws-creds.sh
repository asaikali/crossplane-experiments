SCRIPT_DIR=$(dirname "${0}")
mkdir -p ${SCRIPT_DIR}/kubeconfigs
CLUSTER_NAME=${1}
REGION=${2}

echo "getting cluster creds"
set -x
KUBECONFIG=${SCRIPT_DIR}/kubeconfigs/aws-${CLUSTER_NAME}.yaml

aws eks update-kubeconfig \
 --region ${REGION} \
 --name ${CLUSTER_NAME} \
 --kubeconfig $KUBECONFIG 
