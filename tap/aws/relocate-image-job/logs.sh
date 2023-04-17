# kubectl delete -f test-job.yaml
# kubectl apply -f test-job.yaml
kubectl logs job.batch/relocate-images -n crossplane-system
