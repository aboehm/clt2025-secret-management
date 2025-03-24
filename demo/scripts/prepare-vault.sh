#!/bin/sh -e

# Generate a secret in the store
kubectl exec -n vault vault-0 -- \
    vault kv put clt2025/kubernetes my_secret="A vault secret: $(pwgen -s 8 1)"

kubectl apply -f kubernetes/vault-secret.yml
