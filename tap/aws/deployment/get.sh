echo "-------------------------------------------------------------------------"
echo "Registry" 
echo ""
kubectl get xdeployments,xrepos,Repository.ecr.aws.upbound.io

echo ""
echo "-------------------------------------------------------------------------"
echo "Network" 
echo ""
kubectl get vpc,subnet,internetgateway,defaultroutetable