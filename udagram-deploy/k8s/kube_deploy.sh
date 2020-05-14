#!/bin/sh

echo "Deploying Env and AWS secrets"
kubectl delete secret env-secret
kubectl create -f udagram-deploy/k8s/env-secret.yaml
kubectl delete secret aws-secret
kubectl create -f udagram-deploy/k8s/aws-secret.yaml

echo "Deploying Env"
kubectl delete configmap env-config 
kubectl create -f udagram-deploy/k8s/env-configmap.yaml

sleep 10

echo "Deploying Backend-Feed"
kubectl apply -f udagram-deploy/k8s/backend-feed-deployment.yaml
kubectl apply -f udagram-deploy/k8s/backend-feed-service.yaml

echo "Deploying Backend-User"
kubectl apply -f udagram-deploy/k8s/backend-user-deployment.yaml
kubectl apply -f udagram-deploy/k8s/backend-user-service.yaml

echo "Deploying reverseproxy"
kubectl apply -f udagram-deploy/k8s/reverseproxy-deployment.yaml
kubectl apply -f udagram-deploy/k8s/reverseproxy-service.yaml

echo "Deploying frontend"
kubectl apply -f udagram-deploy/k8s/frontend-deployment.yaml
kubectl apply -f udagram-deploy/k8s/frontend-service.yaml

sleep 20

kubectl get all