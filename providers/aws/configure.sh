#!/bin/bash

readonly AWS_PROFILE=default

#
# Determine the aws creds to use with cross plane
#
readonly AWS_CREDS="
[default]
aws_access_key_id = $(aws configure get aws_access_key_id --profile $AWS_PROFILE)
aws_secret_access_key = $(aws configure get aws_secret_access_key --profile $AWS_PROFILE)
aws_session_token = $(aws configure get aws_session_token --profile $AWS_PROFILE)
"

#
# Create a kuberentes secret for the aws creds 
#
kubectl create secret generic aws-provider-creds \
    -n crossplane-system \
    --from-literal=creds='${AWS_CREDS}' \
    --dry-run=client \
    --output=yaml \
    | kubectl apply -f - 

#
# Create the provider configuration for AWS
#
cat <<EOF | kubectl apply -f -
---
apiVersion: aws.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: aws-provider
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-provider-creds
      key: creds
EOF
