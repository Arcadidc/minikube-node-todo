resource "kubernetes_namespace" "example" {
  metadata {
    name = "server-app"
  }
}

resource "kubernetes_manifest" "deployment_node_todo_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "node-todo-deployment"
      "namespace" = "server-app"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "node-todo"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "node-todo"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "PORT"
                  "value" = "8080"
                },
                {
                  "name" = "TODO_DB_ADDR"
                  "value" = "node-todo-mongodb:27017"
                },
              ]
              "image" = "arcadidc/node-todo:v1.4"
              "name" = "backend"
              "ports" = [
                {
                  "containerPort" = 8080
                  "name" = "http-server"
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu" = "500m"
                  "memory" = "128Mi"
                }
                "requests" = {
                  "cpu" = "250m"
                  "memory" = "64Mi"
                }
              }
            },
          ]
          "initContainers" = [
            {
              "args" = [
                "echo \"Waiting for mongodb to start...\";until (mongo --host node-todo-mongodb:27017 >/dev/null 2>&1) do echo \"Waiting for connection for 2 sec.\"; sleep 2; done",
              ]
              "command" = [
                "/bin/sh",
                "-c",
              ]
              "image" = "mongo:4"
              "name" = "init-db-ready"
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_node_todo_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "server-app"
      "labels" = {
        "app" = "node-todo-service"
      }
      "name" = "node-todo-service"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 8080
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "node-todo"
      }
      "type" = "LoadBalancer"
    }
  }
}
resource "kubernetes_manifest" "deployment_node_todo_mongodb" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "namespace" = "server-app"
      "labels" = {
        "app" = "node-todo"
        "tier" = "db"
        "namespace" = "server-app"
      }
      "name" = "node-todo-mongodb"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "node-todo"
          "tier" = "db"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "node-todo"
            "tier" = "db"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "mongo:4"
              "name" = "mongo"
              "ports" = [
                {
                  "containerPort" = 27017
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu" = "500m"
                  "memory" = "128Mi"
                }
                "requests" = {
                  "cpu" = "250m"
                  "memory" = "64Mi"
                }
              }
            },
          ]
        }
      }
    }
  }
}
resource "kubernetes_manifest" "service_node_todo_mongodb" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "namespace" = "server-app"
      "labels" = {
        "app" = "node-todo"
        "tier" = "db"
      }
      "name" = "node-todo-mongodb"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 27017
          "targetPort" = 27017
        },
      ]
      "selector" = {
        "app" = "node-todo"
        "tier" = "db"
      }
    }
  }
}
