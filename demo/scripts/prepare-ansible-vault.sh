#!/bin/sh

# Generate a vault password for the script
[ -f "${HOME}/.ansible-vault-pass" ] || pwgen -s 32 1 >${HOME}/.ansible-vault-pass

cd ansible
if ! [ -f ansible/host_vars/localhost.yml ] ; then
    # Generate an encrypted variables for localhost
    echo "my_secret: An ansible vault secret $(pwgen -s 16 1)" >host_vars/localhost.yml
    ansible-vault encrypt --output host_vars/localhost.yml host_vars/localhost.yml
fi
