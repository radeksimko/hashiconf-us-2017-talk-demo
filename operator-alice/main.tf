provider "kubernetes" {
  config_context = "gke_hc-terraform-radek_us-central1-a_marcellus-wallace"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "terraform-example-namespace"
  }
}

resource "kubernetes_limit_range" "example" {
    metadata {
        name = "terraform-example"
        namespace = "${kubernetes_namespace.example.metadata.0.name}"
    }
    spec {
        limit {
            type = "Pod"
            max {
                cpu = "1000m"
                memory = "1024M"
            }
        }
    }
}
