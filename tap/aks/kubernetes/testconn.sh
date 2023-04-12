kubectl -n default get secret green-tap-full-1 --output jsonpath="{.data.kubeconfig}" | base64 -d | tee kubeconfig.yaml
export KUBECONFIG=$PWD/kubeconfig.yaml
kubectl get nodes
kubectl get po -A
kubectl get ns
unset KUBECONFIG
rm $PWD/kubeconfig.yaml
