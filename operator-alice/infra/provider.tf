provider "google" {
  credentials = "${file("~/.gcloud/hashicorp.json")}"
  project = "hc-terraform-radek"
  region = "us-west1"
}