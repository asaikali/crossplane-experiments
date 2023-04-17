#!/bin/bash

SA=$(kubectl -n crossplane-system get sa -o name | grep provider-kubernetes | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding \
  provider-kubernetes-admin-binding \
  --clusterrole cluster-admin \
  --serviceaccount="${SA}" \
  --dry-run=client -o yaml | kubectl apply -f - 

kubectl apply -f provider-config.yaml