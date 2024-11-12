terraform {
  required_version = "~> 1.9"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.44.0"
    }
  }
}




provider "google" {
  credentials = var.google_credentials_file
  project     = var.project
  region      = var.region
}
