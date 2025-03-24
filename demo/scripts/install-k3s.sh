#!/bin/sh
set -e

echo ""
echo "#######################################"
echo "# DON'T USE THIS IN REAL ENVIRONMENTS #"
echo "# THIS IS ONLY A DEMO                 #" 
echo "#######################################"
echo ""

# Install k3s
curl -sfL https://get.k3s.io | sh -
# Change permisisons and link kubectl config to k3s
install -d -m 700 -o vagrant -g vagrant /home/vagrant/.kube
install -m 600 -o vagrant -g vagrant /etc/rancher/k3s/k3s.yaml ~/.kube/config

chmod 644 /etc/rancher/k3s/k3s.yaml
kubectl create namespace clt2025 || true
