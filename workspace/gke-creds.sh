SCRIPT_DIR=$(dirname "${0}")
mkdir -p ${SCRIPT_DIR}/kubeconfigs
CLUSTER_NAME=${1}
GCP_PROJECT_ID=${2}
GCP_REGION=${3}

echo "getting cluster creds"
set -x
KUBECONFIG=${SCRIPT_DIR}/kubeconfigs/gke-${CLUSTER_NAME}.yaml \
gcloud container clusters get-credentials \
${CLUSTER_NAME} \
--project=${GCP_PROJECT_ID} \
--region=${GCP_REGION} 
echo "kubeconfig file at ${KUBE_FILE}"
