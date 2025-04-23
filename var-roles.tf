# Role definitions for the IAM Terraform project
# These variables define custom roles for Kubernetes and project-level permissions
#
# Usage:
# - custom_roles: Define custom roles for any GCP resource
#   - role_id: Unique identifier for the role
#   - title: Display name of the role
#   - description: Description of the role's purpose
#   - permissions: List of GCP permissions required
#
# Example:
# custom_roles = {
#   "my_k8s_role" = {
#     role_id     = "my_k8s_role",
#     title       = "My Kubernetes Role",
#     description = "Role for managing Kubernetes resources",
#     permissions = ["container.clusters.get", "container.secrets.get"]
#   }
# }

variable "custom_roles" {
  type = map(object({
    role_id     = string
    title       = string
    description = string
    permissions = list(string)
  }))
  default = {
    "k8s_secret_manager" = {
      role_id     = "k8s_secret_manager",
      title       = "Kubernetes Secret Manager Role",
      description = "Role that gives permissions to manage kubernetes secret resources",
      permissions = [
        "container.clusters.get",
        "container.clusters.getCredentials",
        "container.namespaces.get",
        "container.secrets.create",
        "container.secrets.delete",
        "container.secrets.get",
        "container.secrets.update",
      ]
    },
    "docker_image_puller" = {
      role_id     = "docker_image_puller",
      title       = "Docker Image Puller Role",
      description = "Role that gives permissions to pull Docker images from Artifacts Registry",
      permissions = [
        "artifactregistry.repositories.downloadArtifacts",
      ]
    },
    "docker_image_pusher" = {
      role_id     = "docker_image_pusher",
      title       = "Docker Image Pusher Role",
      description = "Role that gives permissions to push Docker images to Artifacts Registry",
      permissions = [
        "artifactregistry.repositories.uploadArtifacts",
      ]
    }
  }
}
