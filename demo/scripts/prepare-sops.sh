#!/bin/sh

KEY_FILE="${HOME}/.config/sops/age/keys.txt"

mkdir -p "${HOME}/.config/sops/age/"
if ! [ -f .sops.yaml ] ; then
    age-keygen >${KEY_FILE}

    cat >.sops.yaml <<EOF
creation_rules:
  - age: >-
      $(grep 'public key:' "${KEY_FILE}" |sed 's/# public key: //g')
store:
  format: yaml
EOF
fi

if ! [ -f sops-secret.txt ] ; then
    # Create a secret and encrypt it
    echo "This is a SOPS secret: $(pwgen -s 8 1)" >sops-secret.txt
    sops encrypt --in-place sops-secret.txt
fi
