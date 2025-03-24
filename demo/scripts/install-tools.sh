#!/bin/sh -e

set -x

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL -o /etc/apt/keyrings/opentofu.gpg https://get.opentofu.org/opentofu.gpg
curl -fsSL https://packages.opentofu.org/opentofu/tofu/gpgkey \
    | gpg --no-tty --batch --dearmor -o /etc/apt/keyrings/opentofu-repo.gpg >/dev/null
chmod a+r /etc/apt/keyrings/opentofu.gpg /etc/apt/keyrings/opentofu-repo.gpg
echo \
  "deb [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main
deb-src [signed-by=/etc/apt/keyrings/opentofu.gpg,/etc/apt/keyrings/opentofu-repo.gpg] https://packages.opentofu.org/opentofu/tofu/any/ any main" | \
  tee /etc/apt/sources.list.d/opentofu.list > /dev/null
chmod a+r /etc/apt/sources.list.d/opentofu.list

# Install some tools
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    jq \
    pipx \
    pwgen \
    tofu

# Download binaries
wget \
    'https://get.helm.sh/helm-v3.17.1-linux-amd64.tar.gz' \
    'https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.28.0/kubeseal-0.28.0-linux-amd64.tar.gz' \
    'https://github.com/getsops/sops/releases/download/v3.9.4/sops-v3.9.4.linux.amd64' \
    'https://github.com/derailed/k9s/releases/download/v0.40.5/k9s_linux_amd64.deb' \
    'https://releases.hashicorp.com/vault/1.19.0/vault_1.19.0_linux_amd64.zip'
# Check hashes
sha256sum -c /vagrant_data/scripts/tools.sha256

# Install helm
tar -xvzf helm-v3.17.1-linux-amd64.tar.gz
sha256sum helm-v3.17.1-linux-amd64.tar.gz
install -m 755 linux-amd64/helm /usr/local/bin/
rm -rf linux-amd64 helm-v3.17.1-linux-amd64.tar.gz

# Install kubeseal
tar -xvzf kubeseal-0.28.0-linux-amd64.tar.gz kubeseal
install -m 755 kubeseal /usr/local/bin/kubeseal
rm -f kubeseal kubeseal-0.28.0-linux-amd64.tar.gz

# Install sops
install -m 755 -o root -g root sops-v3.9.4.linux.amd64 /usr/local/bin/sops
rm sops-v3.9.4.linux.amd64

# Install vault
unzip -o vault_1.19.0_linux_amd64.zip vault
install -m 755 -o root -g root vault /usr/local/bin/vault

# Install ansible
PIPX_HOME=/opt/ansible PIPX_BIN_DIR=/usr/local/bin pipx install --include-deps ansible-core
# Install dependencies for HashiCorp Vault, kubernetes
PIPX_HOME=/opt/ansible PIPX_BIN_DIR=/usr/local/bin pipx inject ansible-core hvac kubernetes

# Install k9s
dpkg -i k9s_linux_amd64.deb
rm -f k9s_linux_amd64.deb
