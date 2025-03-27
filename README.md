# Cloud Run Terraform Module

This Terraform module deploys a Cloud Run service with DNS configuration.

## Features

- Secure defaults (public access disabled by default)
- Input validation for all variables
- Remote state management
- Comprehensive outputs
- Error handling for DNS operations

## Usage

```hcl
module "cloud_run" {
  source = "./"

  gcp_project = "my-project"
  gcp_region  = "us-central1"
  
  cloud_run_configs = {
    name               = "my-service"
    image_uri          = "gcr.io/my-project/image:latest"
    min_instance_count = 1
    max_instance_count = 3
    port               = 8080
  }

  # DNS Configuration
  subdomain_name   = "api"
  root_domain_name = "example.com"
  dns_zone_name    = "example-zone"
}
```

## Requirements

- Terraform >= 1.5.0
- Google Cloud Provider >= 5.0

## Inputs

See [variables.tf](./variables.tf) for complete documentation of all input variables.

## Outputs

See [outputs.tf](./outputs.tf) for complete documentation of all outputs.

## Security

By default, the Cloud Run service is not publicly accessible. To enable public access:

```hcl
cloud_run_public_access = true
```
