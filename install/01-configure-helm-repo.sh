#!/bin/bash

set -x

helm repo add crossplane-stable https://charts.crossplane.io/stable 
helm repo update
