#!/bin/bash
set -e
# Create namespace
kubectl create namespace mysql --dry-run=client -o yaml | kubectl apply -f -
# Apply secret
kubectl apply -f secret.yml
# Apply headless service
kubectl apply -f service.yml
# Apply StatefulSet
kubectl apply -f statefulset.yml
# Apply app deployment
kubectl apply -f app-deployment.yml
# Wait for MySQL pods
echo "Waiting for MySQL pods..."
kubectl wait --for=condition=ready pod/mysql-0 -n mysql --timeout=120s
echo "All resources deployed successfully!"
