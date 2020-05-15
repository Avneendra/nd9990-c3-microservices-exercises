#!/bin/sh

kubectl delete secret env-secret
kubectl create -f udagram-deploy/k8s/env-secret.yaml
kubectl delete secret aws-secret
kubectl create -f udagram-deploy/k8s/aws-secret.yaml
kubectl delete configmap env-config 
kubectl create -f udagram-deploy/k8s/env-configmap.yaml
kubectl apply -f udagram-deploy/k8s/backend-feed-deployment.yaml
kubectl apply -f udagram-deploy/k8s/backend-feed-service.yaml
kubectl apply -f udagram-deploy/k8s/backend-user-deployment.yaml
kubectl apply -f udagram-deploy/k8s/backend-user-service.yaml
kubectl apply -f udagram-deploy/k8s/reverseproxy-deployment.yaml
kubectl apply -f udagram-deploy/k8s/reverseproxy-service.yaml
kubectl apply -f udagram-deploy/k8s/frontend-deployment.yaml
kubectl apply -f udagram-deploy/k8s/frontend-service.yaml

sleep 10

kubectl get pods