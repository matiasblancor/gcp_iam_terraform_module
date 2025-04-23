resource "google_service_account" "custom_service_account" {
  project      = var.project_id
  for_each     = var.custom_service_account
  account_id   = each.value.account_id
  description  = each.value.description
  display_name = each.value.display_name
}

resource "google_service_account_key" "custom_service_account_keys" {
  for_each = {
    for sa, sak in var.custom_service_account :
    sa => sak if sak.create_key
  }
  service_account_id = google_service_account.custom_service_account[each.key].name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

output "custom_service_account_info" {
  value = google_service_account.custom_service_account
}

output "custom_service_account_keys" {
  value     = google_service_account_key.custom_service_account_keys
  sensitive = true
}
