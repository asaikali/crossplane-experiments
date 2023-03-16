#!/bin/bash
#
# See crossplane documentation:
# https://docs.crossplane.io/v1.11/getting-started/provider-gcp/#install-the-gcp-provider
#

# configure PROJECT_ID with `gcloud config set project xxxx`
readonly PROJECT_ID=$(gcloud config get project)
readonly CODE_NAME="crossplane-gcp-provider"
readonly GCP_CREDS_FILE=../../workspace/gcp-credentials.json
readonly GCP_SERVICE_ACCOUNT_NAME="${CODE_NAME}"
readonly GCP_SERVICE_ACCOUNT_EMAIL="${CODE_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

# Create service account
gcloud iam service-accounts create ${GCP_SERVICE_ACCOUNT_NAME} --display-name="${GCP_SERVICE_ACCOUNT_NAME}" --project=${PROJECT_ID} --description="Used by Crossplane provider"

# Create key and credentials
gcloud iam service-accounts keys create ${GCP_CREDS_FILE} --iam-account=${GCP_SERVICE_ACCOUNT_EMAIL}

# Add permissions for the service-account
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member serviceAccount:${GCP_SERVICE_ACCOUNT_EMAIL} --role="roles/owner"

# Encode GCP credentials to base64
readonly BASE64_GCP_CRED=$(cat ${GCP_CREDS_FILE} | base64)

#
# Create a kubernetes secret for the GCP creds 
#

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: gcp-community-provider-creds
  namespace: crossplane-system
data:
  creds: ${BASE64_GCP_CRED}
EOF

#
# Create the provider configuration for GCP
#
cat <<EOF | kubectl apply -f -
---
apiVersion: gcp.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: gcp-community-provider
spec:
  projectID: ${PROJECT_ID}
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gcp-community-provider-creds
      key: creds
EOF
