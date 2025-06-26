#!/bin/bash
./mvnw clean package -DskipTests
docker build -t <your-dockerhub>/java-devops-app:latest .
docker push <your-dockerhub>/java-devops-app:latest
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
