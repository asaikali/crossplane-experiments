kubectl apply -f definition.yaml 
ytt -f composition.yaml | kubectl apply -f - 