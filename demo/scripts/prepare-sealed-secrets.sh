#!/bin/sh

if ! [ -f kubernetes/sealed-secret.yml ] ; then
    # Generate a kubernetes secret
    kubectl create secret generic sealed-secret \
        --dry-run=client \
        --from-literal=my_secret="This is a sealed secret: $(pwgen -s 16 1)" \
        -o yaml \
        >kubernetes/sealed-secret.yml
    # Seal it
    kubeseal -f kubernetes/sealed-secret.yml -w kubernetes/sealed-secret.yml
fi
