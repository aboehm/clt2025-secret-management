#!/bin/sh
set -e

# Add bitname helm repo
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets

# Install sealed secrets
helm upgrade --install \
    --namespace kube-system \
    sealed-secrets-controller \
    sealed-secrets/sealed-secrets
