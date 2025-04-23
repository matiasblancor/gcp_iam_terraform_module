# GCP IAM Terraform Module

A Terraform module for managing Google Cloud Platform (GCP) Identity and Access Management (IAM) resources. This module provides a comprehensive solution for managing IAM users, custom roles, and role assignments across users, groups, and service accounts.

## Features

- **Custom Role Management**: Create and manage custom IAM roles with granular permissions
- **Service Account Management**: Create and manage service accounts with optional key generation
- **Role Bindings**: Assign GCP native and custom roles to users, groups, and service accounts

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0

## Authentication

Before using this module, you need to set up authentication with Google Cloud:

1. Create a service account with the necessary permissions
2. Download the service account key file (JSON)
3. Set the environment variable:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/service-account-key.json"
```

## Module Structure

```
├── README.md
├── main.tf
├── provider.tf
├── var-global.tf
├── var-roles.tf
├── var-service_accounts.tf
├── var-role_bindings.tf
├── iam/
│   ├── main.tf
│   └── variables.tf
├── roles/
│   ├── main.tf
│   └── variables.tf
└── serviceAccounts/
    ├── main.tf
    └── variables.tf
```

## Examples

### Custom Roles Definition

```hcl
# var-roles.tf
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
        "container.secrets.create",
        "container.secrets.delete",
        "container.secrets.get",
        "container.secrets.update",
      ]
    }
  }
}
```

### Service Accounts Definition

```hcl
# var-service_accounts.tf
variable "custom_service_account" {
  type = map(object({
    account_id   = string
    description  = string
    display_name = string
    create_key   = bool
  }))
  default = {
    "app-secret-manager" = {
      account_id   = "app-secret-manager",
      display_name = "Application Secret Manager",
      description  = "Service Account to manage secrets resources",
      create_key   = true,
    }
  }
}
```

### Role Bindings Definition

```hcl
# var-role_bindings.tf
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
    "k8s_secret_manager" = {
      members = [
        {
          same_project = true
          account_id   = "app-secret-manager"
        }
      ]
    }
  }
}

variable "iam_native_roles_binding" {
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
          same_project = true,
          account_i    = "app-secret-manager",
        }
      ]
    }
  }
}
```

## License

Copyright 2024

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
