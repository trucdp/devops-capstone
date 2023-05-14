#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Run the Docker Hub container with kubernetes
kubectl apply -f k8s/

# List kubernetes resources
echo
echo "Listing deployments"
kubectl get deployments -o wide
echo
echo "Listing services"
kubectl get services -o wide
echo
echo "Listing pods"
kubectl get pods -o wide

# Forward the container port to a host port
#kubectl port-forward service/${DEPLOYMENT_NAME} ${HOST_PORT}:${CONTAINER_PORT}
