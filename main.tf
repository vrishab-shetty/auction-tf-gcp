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


data "google_dns_managed_zone" "dns_zone" {
  name = var.dns_zone_name
}

resource "google_cloud_run_domain_mapping" "domain_mapping" {
  name = "${var.subdomain_name}.${var.root_domain_name}"
  location = google_cloud_run_v2_service.default.location
  metadata {
    namespace = var.gcp_project
  }
  spec {
    route_name = google_cloud_run_v2_service.default.name
    certificate_mode = "AUTOMATIC"
  }
}


resource "google_dns_record_set" "default" {
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  name         = "${var.subdomain_name}.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type         = "CNAME"
  rrdatas      = ["ghs.googlehosted.com."]
  ttl          = var.dns_record_ttl
}
