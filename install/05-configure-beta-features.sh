#!/bin/bash

helm upgrade crossplane --namespace crossplane-system crossplane-stable/crossplane \
    --set "args={--debug,--enable-composition-functions,--enable-environment-configs}" \
    --set "xfn.enabled=true" \
    --set "xfn.args={--debug}"