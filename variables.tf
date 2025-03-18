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
