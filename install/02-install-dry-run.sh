#!/bin/bash

set -x

helm install crossplane \
crossplane-stable/crossplane \
--dry-run --debug \
--namespace crossplane-system \
--create-namespace
