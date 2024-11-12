resource "google_artifact_registry_repository" "my_repo" {
  location      = var.region
  repository_id = var.artifact_registry
  description   = "example docker repository"
  format        = "DOCKER"
}
