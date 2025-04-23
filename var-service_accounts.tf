# Service Account definitions for the IAM Terraform project
# These variables define service accounts and their configurations
#
# Usage:
# - custom_service_account: Define service accounts and their properties
#   - account_id: Unique identifier for the service account
#   - display_name: Display name of the service account
#   - description: Description of the service account's purpose
#   - create_key: Boolean indicating whether to create a key for the service account
#
# Example:
# custom_service_account = {
#   "my-service-account" = {
#     account_id   = "my-service-account",
#     display_name = "My Service Account",
#     description  = "Service account for my application",
#     create_key   = true
#   }
# }

variable "custom_service_account" {
  type = map(object({
    account_id   = string
    description  = string
    display_name = string
    create_key   = bool
  }))
  default = {
    "k8s-secret-manager" = {
      account_id   = "k8s-secret-manager",
      display_name = "K8S Secret Manager",
      description  = "Service Account to manage kubernetes secrets resources",
      create_key   = true,
    },
    "docker-image-puller" = {
      account_id   = "docker-image-puller",
      display_name = "Docker Image Puller",
      description  = "Service Account to pull docker image from artifacts regisry",
      create_key   = false,
    },
    "docker-image-pusher" = {
      account_id   = "docker-image-pusher",
      display_name = "Docker Image Pusher",
      description  = "Service Account to push docker image to artifacts regisry",
      create_key   = false,
    },
  }
}
