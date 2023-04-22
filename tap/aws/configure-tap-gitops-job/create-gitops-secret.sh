kubectl create secret generic tap-gitops  \
  -n crossplane-system \
  --from-literal=username=${TAP_GITOPS_USERNAME} \
  --from-literal=password=${TAP_GITOPS_PASSWORD} \
  --dry-run=client \
  -o yaml \
  | kubectl apply -f - 