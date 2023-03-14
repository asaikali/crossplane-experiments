#!/bin/bash
#
# See crossplane documentation:
# https://docs.crossplane.io/v1.11/getting-started/provider-azure/#install-the-azure-provider
#

readonly AZURE_SUBSCRIPTION_ID=$(az account show --query id --output tsv)

# Create service principal with Owner role
readonly AZURE_CREDS=$(az ad sp create-for-rbac --name azure-crossplane-provider --sdk-auth --role Owner --scopes /subscriptions/${AZURE_SUBSCRIPTION_ID})
readonly BASE64_AZURE_CRED=$(echo "${AZURE_CREDS}" | base64)

#
# Create a kubernetes secret for the azure creds 
#

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: azure-provider-creds
  namespace: crossplane-system
data:
  creds: ${BASE64_AZURE_CRED}
EOF

#
# Create the provider configuration for Azure
#
cat <<EOF | kubectl apply -f -
---
apiVersion: azure.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: azure-provider
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: azure-provider-creds
      key: creds
EOF

