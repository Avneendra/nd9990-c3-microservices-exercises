#!/bin/sh
echo "Creating backups"
cp -f udagram-deploy/k8s/aws-secret.yaml udagram-deploy/k8s/aws-secret.yaml.backup
cp -f udagram-deploy/k8s/env-secret.yaml udagram-deploy/k8s/env-secret.yaml.backup
cp -f udagram-deploy/k8s/env-configmap.yaml udagram-deploy/k8s/env-configmap.yaml.backup

echo "Deploying secrets"
kubectl delete secret env-secret
kubectl create -f udagram-deploy/k8s/env-secret.yaml
kubectl delete secret aws-secret
#kubectl create -f udagram-deploy/k8s/aws-secret.yaml
echo "Deploying env"
kubectl delete configmap env-config 
kubectl create -f udagram-deploy/k8s/env-configmap.yaml
echo "Deploying feed"
kubectl apply -f udagram-deploy/k8s/backend-feed-deployment.yaml
kubectl apply -f udagram-deploy/k8s/backend-feed-service.yaml
echo "Deploying user"
kubectl apply -f udagram-deploy/k8s/backend-user-deployment.yaml
kubectl apply -f udagram-deploy/k8s/backend-user-service.yaml
echo "Deploying reverseproxy"
kubectl apply -f udagram-deploy/k8s/reverseproxy-deployment.yaml
kubectl apply -f udagram-deploy/k8s/reverseproxy-service.yaml
echo "Deploying frontend"
kubectl apply -f udagram-deploy/k8s/frontend-deployment.yaml
kubectl apply -f udagram-deploy/k8s/frontend-service.yaml

echo "Cleaning up"
#mv -f udagram-deploy/k8s/aws-secret.yaml.backup udagram-deploy/k8s/aws-secret.yaml
mv -f udagram-deploy/k8s/env-secret.yaml.backup udagram-deploy/k8s/env-secret.yaml
mv -f udagram-deploy/k8s/env-configmap.yaml.backup udagram-deploy/k8s/env-configmap.yaml
