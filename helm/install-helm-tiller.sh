#!/bin/sh

# This installs Helm and Tiller components into an
# existing Raspberri Pi Kubernetes cluster.

wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-arm.tar.gz
tar xvzf helm-v2.12.3-linux-arm.tar.gz
sudo mv linux-arm/helm /bin/helm
Rm -rf linux-arm

kubectl apply -f tiller-rbac-config.yml

helm init --tiller-image=clayshek/tiller-arm --service-account tiller
