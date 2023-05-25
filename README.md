# Node Todo App

A Node app built with MongoDB and Angular. For demonstration purposes and a tutorial.

Node provides the RESTful API. Angular provides the frontend and accesses the API. MongoDB stores like a hoarder.

## Requirements

- [Node and npm](http://nodejs.org)
- [Kubectl](https://kubernetes.io/docs/reference/kubectl/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Docker](https://www.docker.com/)

## Installation


### Are you a Linux user? Good luck! There is a script that does it for you:

- There is a script that can be found at the project root called `start.sh` , which checks if the requirements are installed.
- The script also starts minikube and apply the YAML files that can be found in the `Kubernetes-manifests` folder.
- It also runs the command `minikube service node-todo-service --url` for you, this command  basically  exposes the service so you can access it from your host.
- Once run, you can find the link to your API server in the file (minikube_service_output.txt)

### Are you a Windows user or the script didn't work?  Some extra steps:
- You will need to access inside the folder `kubernetes-manifests` and execute `kube apply -f` with all of them. The pods will wait between them to be available so no need to do it in order!
- After they are running (You can check it with `kubectl get pods` if needed) you will need to expose the service executing the following command:
 > minikube service node-todo-service --url
- This will prompt an IP:PORT , this is important as it will be needed in order to configure our [cli-tool](https://github.com/Arcadidc/cli-tool) program!




## Initial application was taken from https://github.com/scotch-io/node-todo
