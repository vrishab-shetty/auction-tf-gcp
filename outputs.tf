output "cloud_run_service_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = google_cloud_run_v2_service.default.uri
}

output "cloud_run_service_status" {
  description = "The status of the Cloud Run service"
  value       = google_cloud_run_v2_service.default.conditions
}

output "domain_mapping_status" {
  description = "The status of the domain mapping"
  value       = google_cloud_run_domain_mapping.domain_mapping.status
  sensitive   = true
}

output "dns_record" {
  description = "The created DNS record"
  value       = local.dns_zone_exists ? google_dns_record_set.default[0] : null
  sensitive   = true
}
