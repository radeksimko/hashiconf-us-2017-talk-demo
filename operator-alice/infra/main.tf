resource "google_container_cluster" "primary" {
  name               = "marcellus-wallace"
  zone               = "us-central1-a"
  initial_node_count = 3

  additional_zones = [
    "us-central1-b"
  ]

  master_auth {
    username = "${random_string.user.result}"
    password = "${random_string.password.result}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

output "zone" {
  value = "${google_container_cluster.primary.zone}"
}

output "cluster_name" {
  value = "${google_container_cluster.primary.name}"
}

# gcloud container clusters get-credentials --zone=$(terraform output zone) $(terraform output cluster_name)
