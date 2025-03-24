#!/bin/sh -e

# Deploy service with vault secret
kubectl apply -f kubernetes/vault-secret.yml -f kubernetes/simple-app-with-vault.yml 
