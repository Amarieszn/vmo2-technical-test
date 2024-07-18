module "cloud_run" {
  source         = "../../modules/cloud-run"
  project_id     = var.project_id
  region         = var.region
  service_name   = var.service_name
  image          = var.image
  invoker_member = var.invoker_member
}

resource "google_service_account" "invoker" {
  account_id   = "cloud-run-invoker"
  display_name = "Cloud Run Invoker"
  project      = var.project_id
}

resource "google_project_iam_member" "invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.invoker.email}"
}
