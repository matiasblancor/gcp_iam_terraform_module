# Google Cloud Platform Provider
# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  region = var.region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.30.0"
    }
  }
  backend "gcs" {
    bucket = "terraform-states-bucket"
    prefix = "terraform/iam/infrastructure/state"
  }
}
