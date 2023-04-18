kubectl create secret generic tanzunet  \
  -n crossplane-system \
  --from-literal=username=${TANZU_NET_USERNAME} \
  --from-literal=password=${TANZU_NET_PASSWORD} \
  --dry-run=client \
  -o yaml \
  | kubectl apply -f - 