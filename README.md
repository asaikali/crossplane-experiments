# crossplane-experiments

## Install Crossplane 

The `install` folder contains a set of numbered bash scripts that should 
be run in sequence in order to install Crossplane into a Kuberentes cluster.  

## Install providers 

The `provider` folder contains set of subdirectories to configure the various
providers. Each sub directory contains a `provider.yaml` file to deploy the 
provider and a `configure.sh` script to configure the provider with creds 
required to deploy something.

Use the following process to install a provider:

1. kubctl apply the provider yaml
2. `kubectl get Providers` and wait for the provider to show healthy status
3. run the `configure.sh` script to configrue the provider
