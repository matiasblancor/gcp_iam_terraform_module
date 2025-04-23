resource "google_project_iam_custom_role" "custom_roles" {
  for_each    = var.custom_roles
  project     = var.project_id
  role_id     = each.value.role_id
  title       = each.value.title
  description = each.value.description
  permissions = each.value.permissions
}

output "custom_roles_output" {
  value = google_project_iam_custom_role.custom_roles
}
