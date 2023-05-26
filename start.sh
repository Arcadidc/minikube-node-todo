#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install Minikube if not installed
if ! command_exists minikube; then
  echo "Minikube not found. Installing Minikube..."
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube
  sudo mv minikube /usr/local/bin/
fi

# Install Docker if not installed
if ! command_exists docker; then
  echo "Docker not found. Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER 
  sudo systemctl enable docker
  sudo systemctl start docker
fi

# Install kubectl if not installed
if ! command_exists kubectl; then
  echo "kubectl not found. Installing kubectl..."
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubectl
fi

# Start Minikube
sleep 10
minikube start

# Apply YAML files using kubectl
kubectl apply -f kubernetes-manifests/deployment.yaml -f kubernetes-manifests/mongo.deployment.yaml -f kubernetes-manifests/mongo.service.yaml -f kubernetes-manifests/service.yaml

# Execute minikube service command
output_file="minikube_service_output.txt"
minikube service node-todo-service --url > "$output_file"
echo "Output saved to $output_file"