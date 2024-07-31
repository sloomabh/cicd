locals {
  postgres_env = [
    {
      name  = "POSTGRES_PASSWORD"
      value = var.db_password
    }
  ]

  mysql_env = [
    {
      name  = "MYSQL_ROOT_PASSWORD"
      value = var.db_password
    }
  ]
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "${var.name}-deployment-${var.type}"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "${var.name}-${var.type}"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.name}-${var.type}"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "${var.name}-service-${var.type}"
  }

  spec {
    selector = {
      app = "${var.name}-${var.type}"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = var.node_port != 0 ? var.node_port : null
    }

    type = "NodePort"
  }
}


resource "kubernetes_deployment" "database" {
  metadata {
    name = "${var.type}-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.type
      }
    }

    template {
      metadata {
        labels = {
          app = var.type
        }
      }

      spec {
        container {
          name  = var.type
          image = var.database_image

          port {
            container_port = var.container_port
          }

          dynamic "env" {
            for_each = var.type == "postgres" ? local.postgres_env : var.type == "mysql" ? local.mysql_env : []
            content {
              name  = env.value.name
              value = env.value.value
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "database" {
  metadata {
    name = "${var.type}-service"
  }

  spec {
    selector = {
      app = var.type
    }

    port {
      port        = var.container_port
      target_port = var.container_port
     
    }

    type = "ClusterIP"
  }
}