#!/bin/bash

set -x 

helm install crossplane \
crossplane-stable/crossplane \
--namespace crossplane-system \
--create-namespace

kubectl get pods -n crossplane-system