resource "google_cloud_run_service" "default" {
  name     = var.service_name
  location = var.region
  project = var.project_id

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  service     = google_cloud_run_service.default.name
  location    = google_cloud_run_service.default.location
  role        = "roles/run.invoker"
  member      = var.invoker_member
  project     = var.project_id
}

resource "google_compute_global_address" "default" {
  name = "${var.service_name}-ip"
  project = var.project_id
}

resource "google_compute_url_map" "default" {
  name            = "${var.service_name}-url-map"
  default_service = google_compute_backend_service.default.self_link
  project = var.project_id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.service_name}-http-proxy"
  url_map = google_compute_url_map.default.self_link
  project = var.project_id
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "${var.service_name}-forwarding-rule"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
  ip_address = google_compute_global_address.default.address
  project = var.project_id
}

resource "google_compute_backend_service" "default" {
  name        = "${var.service_name}-backend"
  port_name   = "http"
  protocol    = "HTTP"
  health_checks = [google_compute_http_health_check.default.self_link]
  project = var.project_id
}

resource "google_compute_http_health_check" "default" {
  name               = "${var.service_name}-health-check"
  request_path       = "/"
  port               = "8080"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2
  project = var.project_id
}
