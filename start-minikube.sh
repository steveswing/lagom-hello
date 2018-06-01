#!/bin/bash -ev
(minikube delete || true) &>/dev/null
minikube start --memory 8192 --cpus 4 --kubernetes-version=v1.10.0
#minikube start --memory 8192 --cpus 10 --bootstrapper=kubeadm --extra-config=apiserver.authorization-mode=RBAC --vm-driver kvm2 --kubernetes-version=v1.10.0
#Setup Docker engine context to point to Minikube
eval $(minikube docker-env)
#Enable Ingress Controller
minikube addons enable ingress
#kubectl --namespace=kube-system create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default

sbt -DbuildTarget=kubernetes clean docker:publishLocal "deploy minikube"
