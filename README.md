# Node Todo App

A Node app built with MongoDB and Angular. For demonstration purposes and a tutorial.

Node provides the RESTful API. Angular provides the frontend and accesses the API. MongoDB stores like a hoarder.

## Requirements

- [Node and npm](http://nodejs.org)
- MongoDB: Make sure you have your own local or remote MongoDB database URI configured in `config/database.js`
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)

## Installation

1. Clone the repository: `git clone git@github.com:arcadidc/minikube-node-todo`
2. Install the application: `npm install`
3. Place your own MongoDB URI in `config/database.js`
3. Start the server: `node server.js`
4. View in browser at `http://localhost:8080`




#### Initial application was taken from https://github.com/scotch-io/node-todo


minikube install
need docker
need to go kubernetes-manifests 
execute minikube service node-todo-service --url