variable "gcp_project" {
  type = string
}

variable "gcp_region" {
  type    = string
  default = "us-central1"
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
}

# DNS
variable "subdomain_name" {
  type = string
}

variable "root_domain_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "dns_record_ttl" {
  type = number
}
