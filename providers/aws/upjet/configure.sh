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

readonly BASE64_AWS_CRED=$(echo "${AWS_CREDS}" | base64)

#
# Create a kuberentes secret for the aws creds 
#

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: aws-upjet-provider-creds
  namespace: crossplane-system
data:
  creds: ${BASE64_AWS_CRED}
EOF

#
# Create the provider configuration for AWS
#
cat <<EOF | kubectl apply -f -
---
apiVersion: aws.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: aws-upjet-provider
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: aws-upjet-provider-creds
      key: creds
EOF
