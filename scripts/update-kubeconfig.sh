#!/bin/bash
sudo chmod 777 /etc/rancher/k3s/k3s.yaml
aws eks --region eu-west-3 update-kubeconfig --name petclinic-cluster
