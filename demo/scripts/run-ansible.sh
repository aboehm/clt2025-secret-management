#!/bin/sh

cd ansible

# Install dependencies
ansible-galaxy collection install -r requirements.yml

# Use secrets from ansible vault 
ansible-playbook ansible-vault.yml

# Use secrets from sops 
ansible-playbook sops.yml

# Use secrets from vault 
VAULT_TOKEN=$(jq -r '.root_token' /home/vagrant/vault-setup.json) ansible-playbook hashicorp-vault.yml
