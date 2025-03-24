#!/bin/sh -e
set +x

# Add helm repo for HashiCorp
helm repo add hashicorp https://helm.releases.hashicorp.com

# Install Vault
helm upgrade --install \
    --create-namespace --namespace vault \
    --values vault/vault-values.yml \
    vault \
    hashicorp/vault

# Install Vault Operator
helm upgrade --install \
    --create-namespace --namespace vault-secrets-operator-system \
    --values vault/vault-operator-values.yml \
    vault-secrets-operator \
    hashicorp/vault-secrets-operator

if ! [ -f /home/vagrant/vault-setup.json ] ; then
    # Initialize vault and write the import keys in vault-setup.json
    kubectl exec -n vault -it vault-0 -- \
        vault operator init -non-interactive -key-shares=1 -key-threshold=1 -format=json \
        >/home/vagrant/vault-setup.json
else
    echo "Vault already initialized"
fi
sleep 1

UNSEAL_KEY=$(jq -r '.unseal_keys_hex[0]' /home/vagrant/vault-setup.json)
ROOT_TOKEN=$(jq -r '.root_token' /home/vagrant/vault-setup.json)
echo "Unseal Key: ${UNSEAL_KEY}"
echo "Root Token: ${ROOT_TOKEN}"

# Unseal the vault
kubectl exec -n vault vault-0 -- \
    vault operator unseal -non-interactive ${UNSEAL_KEY}

# Log into the vault
kubectl exec -n vault vault-0  -- \
    vault login -no-print -non-interactive ${ROOT_TOKEN}

# Create an access method for kubernetes
kubectl exec -n vault vault-0 -- \
    vault auth enable -path=kubernetes-access kubernetes || true
sleep 1

# Configure access URL
kubectl exec -n vault vault-0 -- \
    sh -c 'vault write auth/kubernetes-access/config kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"'

# Setup a key value store called clt2025
kubectl exec -n vault vault-0 -- \
    vault secrets enable -path=clt2025 kv-v2

# Create a readonly policy for the store
kubectl exec -n vault -i vault-0 -- \
    vault policy write clt2025-readonly /dev/stdin <<EOF
path "clt2025/data/kubernetes" {
    capabilities = ["read", "list"]
}
EOF

# Grant access method & policy to service account of the demo namespace
kubectl exec -n vault vault-0 -- \
    vault write auth/kubernetes-access/role/clt2025-readonly \
    bound_service_account_names=vault-access \
    bound_service_account_namespaces=clt2025 \
    policies=clt2025-readonly \
    audience=vault \
    ttl=24h

# Create service accounts and configure an authentication for them
kubectl apply -f vault/vault-auth-static.yml
