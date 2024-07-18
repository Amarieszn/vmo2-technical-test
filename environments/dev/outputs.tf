output "cloud_run_url" {
  value = module.cloud_run.cloud_run_url
}

output "invoker_service_account_email" {
  value = google_service_account.invoker.email
}