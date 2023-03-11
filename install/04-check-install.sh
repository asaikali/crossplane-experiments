#!/bin/bash

set -x
kubectl get pods -n crossplane-system

set +x
echo ""

set -x
kubectl api-resources  | grep crossplane