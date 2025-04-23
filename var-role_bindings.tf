# Role Binding definitions for the IAM Terraform project
# These variables define the bindings between roles and members (users, groups, service accounts)
#
# Usage:
# - iam_custom_project_role_binding: Define bindings for custom project roles
# - iam_custom_k8s_role_binding: Define bindings for custom Kubernetes roles
# - iam_native_role_binding: Define bindings for native GCP roles
#
# Structure:
# Each binding includes a list of members with the following properties:
#   - same_project: bool    | Indicates if the member is from the same project
#                   | Required
#   - type:         string  | Type of member (serviceAccount, group, user)
#                   | Optional, defaults to "serviceAccount"
#   - account_id:   string  | ID of the service account when same_project is true
#                   | Required when same_project is true
#   - email:        string  | Email address of the member when same_project is false
#                   | Required when same_project is false
#
# Example:
# iam_custom_project_role_binding = {
#   "my_role_binding" = {
#     members = [
#       {
#         same_project = true,
#         account_id   = "my-service-account"
#       },
#       {
#         same_project = false,
#         type        = "email",  
#         email       = "my-email-account@domain.com"
#       }
#     ]
#   }
# }

variable "iam_custom_roles_binding" {
  type = map(object({
    members = list(object({
      same_project = bool,
      type         = optional(string, "serviceAccount"),
      account_id   = optional(string),
      email        = optional(string),
    }))
  }))
  default = {
    "docker_image_puller" = {
      members = [
        {
          same_project = false,
          type         = "serviceAccount",
          email        = "docker-image-puller@other-gcp-project.iam.gserviceaccount.com",
        },
        {
          same_project = true,
          account_id   = "docker-image-puller",
        }
      ],
    },
    "docker_image_pusher" = {
      members = [
        {
          same_project = true,
          account_id   = "docker-image-pusher",
        },
      ],
    },
    "k8s_secret_manager" = {
      members = [
        {
          same_project = true,
          account_id   = "k8s-secret-manager",
        }
      ],
    },
  }
}

variable "iam_native_role_binding" {
  type = map(object({
    role_id = string
    members = list(object({
      same_project = bool,
      type         = optional(string, "serviceAccount"),
      account_id   = optional(string),
      email        = optional(string),
    }))
  }))
  default = {
    "roles/viewer" = {
      role_id = "roles/viewer"
      members = [
        {
          same_project = false,
          type         = "group",
          email        = "workspace-group@domain.com",
        }
      ]
    }
  }
}
