resource "google_project_iam_binding" "iam_custom_roles_binding" {
  for_each = var.iam_custom_roles_binding
  project  = var.project_id
  role     = var.custom_roles[each.key].id
  members = [
    for members in each.value.members :
    members.same_project ? "serviceAccount:${var.custom_service_account_info[members.account_id].email}" : "${members.type}:${members.email}"
  ]
}

resource "google_project_iam_binding" "iam_native_role_binding" {
  for_each = var.iam_native_role_binding
  project  = var.project_id
  role     = each.value.role_id
  members = [
    for members in each.value.members :
    members.same_project ? "serviceAccount:${var.custom_service_account_info[members.account_id].email}" : "${members.type}:${members.email}"
  ]
}
