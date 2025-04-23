module "roles" {
  source       = "./roles"
  region       = var.region
  project_id   = var.project_id
  custom_roles = var.custom_roles
}

module "serviceAccounts" {
  source                 = "./serviceAccounts"
  region                 = var.region
  project_id             = var.project_id
  custom_service_account = var.custom_service_account
}

module "iam" {
  source                      = "./iam"
  region                      = var.region
  project_id                  = var.project_id
  iam_custom_roles_binding    = var.iam_custom_roles_binding
  iam_native_role_binding     = var.iam_native_role_binding
  custom_roles                = module.roles.custom_roles_output
  custom_service_account_info = module.serviceAccounts.custom_service_account_info
}

output "service_account_keys" {
  value     = module.serviceAccounts.custom_service_account_keys
  sensitive = true
}
