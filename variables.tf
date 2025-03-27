variable "gcp_project" {
  type        = string
  description = "The GCP project ID where resources will be deployed"
}

variable "gcp_region" {
  type        = string
  default     = "us-central1"
  description = "The GCP region where resources will be deployed"
  validation {
    condition     = contains(["us-central1", "us-east1", "us-west1", "europe-west1"], var.gcp_region)
    error_message = "Invalid GCP region specified. Must be one of: us-central1, us-east1, us-west1, europe-west1"
  }
}

variable "cloud_run_configs" {
  type = object({
    name               = string
    location           = optional(string, "us-central1")
    image_uri          = string
    min_instance_count = number
    max_instance_count = number
    port               = number
  })
  description = "Configuration for Cloud Run service"
  validation {
    condition     = var.cloud_run_configs.min_instance_count <= var.cloud_run_configs.max_instance_count
    error_message = "min_instance_count must be less than or equal to max_instance_count"
  }
}

# DNS
variable "subdomain_name" {
  type        = string
  description = "Subdomain name for the Cloud Run service"
}

variable "root_domain_name" {
  type        = string
  description = "Root domain name for DNS records"
}

variable "dns_zone_name" {
  type        = string
  description = "Name of the DNS managed zone in Cloud DNS"
}

variable "dns_record_ttl" {
  type        = number
  default     = 300
  description = "TTL for DNS records in seconds"
  validation {
    condition     = var.dns_record_ttl >= 60 && var.dns_record_ttl <= 86400
    error_message = "TTL must be between 60 and 86400 seconds"
  }
}

variable "cloud_run_public_access" {
  type        = bool
  default     = false
  description = "Whether to allow public access to the Cloud Run service. Defaults to false for security."
}
