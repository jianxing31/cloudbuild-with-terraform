variable "project" {
  type        = string
  description = "GCP Project name"
}

variable "region" {
  type        = string
  description = "GCP Resource Region"
}

variable "google_credentials_file" {
  type        = string
  description = "GCP Credential file path"
}

variable "artifact_registry" {
  type        = string
  description = "Artifact registry name(This resource will be created by tf)"
}

variable "cloudbuild_trigger_name" {
  type        = string
  description = "Cloudbuild trigger name(This resource will be created by tf)"
}

variable "cloudbuild_trigger_sa" {
  type        = string
  description = "The service account used by Cloudbuild, Compute default service account (******-compute@developer.gserviceaccount.com) can be used here."
}

variable "secret_name" {
  type        = string
  description = "GCP secret manager name(This resource will be created by tf)"
}

variable "github_pat_secret" {
  type        = string
  description = "Github pat token"
}

variable "github_cloudbuild_repo_config" {
  type        = map(any)
  description = "Config for github repo used by cloudbuild."
  default     = { repo : "cloudbuild-with-terraform", branch : "master", url : "https://github.com/jianxing31/cloudbuild-with-terraform.git" }
}

variable "sa_serviceagent_secretAccessor" {
  type        = string
  description = "Service account used by cloudbuild for accessing secret manager(e.g. service-*****@gcp-sa-cloudbuild.iam.gserviceaccount.com)."
}

variable "github_app_installation_id" {
  type        = string
  description = "Github Cloudbuild App id"
}

variable "cloudbuild_filename" {
  type        = string
  description = "Cloudbuild yaml filename in your github repo that you want cloudbuild triggers to use"
  default     = "cloudbuild_image.yaml"
}

variable "cloudbuild_filename_cross_repo" {
  type        = string
  description = "Cloudbuild yaml filename in your github repo that you want cloudbuild triggers to use"
  default     = "cloudbuild_cross_repo_access.yaml"
}
