provider "kubernetes" {
  config_context = "minikube"
}

resource "kubernetes_replication_controller" "example" {
  metadata {
    name = "terraform-example"
    labels {
      app = "MyExampleApp"
    }
  }

  spec {
    selector {
      app = "MyExampleApp"
    }
    template {
      container {
        image = "hashicorp/http-echo:0.2.3"
        name  = "example"
        args = ["-text='${var.text}'"]

        resources{
          limits{
            cpu    = "500m"
            memory = "512Mi"
          }
          requests{
            cpu    = "250m"
            memory = "50Mi"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "terraform-example"
  }
  spec {
    selector {
      app = "${kubernetes_replication_controller.example.metadata.0.labels.app}"
    }
    port {
      name = "http"
      port = 80
      target_port = 5678
    }
    type = "NodePort"
  }
}

output "service_name" {
  value = "${kubernetes_service.example.metadata.0.name}"
}
