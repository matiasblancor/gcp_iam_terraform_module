# Global variables for the IAM Terraform project
# These variables are used across all modules and define the basic configuration
#
# Usage:
# - region: Define the GCP region where resources will be created
# - project_id: Define the GCP project ID where resources will be created
#
# Example:
# region = "us-central1"
# project_id = "gcp-project-id"

variable "region" {
  default = "us-central1"
}

variable "project_id" {
  default = "gcp-project-id"
}
