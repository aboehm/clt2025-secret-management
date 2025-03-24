#!/bin/sh -e

cd terraform

# Initialize the modules
tofu init -upgrade

# Apply module
VAULT_TOKEN=$(jq -r '.root_token' /home/vagrant/vault-setup.json) tofu apply -auto-approve
