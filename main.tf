resource "google_cloud_run_v2_service" "default" {
  name                = var.cloud_run_configs.name
  location            = var.cloud_run_configs.location
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = var.cloud_run_configs.image_uri
    }
  }
}

resource "google_cloud_run_v2_service_iam_binding" "public_access_binding" {
  project = google_cloud_run_v2_service.default.project
  location = google_cloud_run_v2_service.default.location
  name = google_cloud_run_v2_service.default.name
  role = "roles/run.invoker"
  members = [
    "allUsers",
  ]
}
