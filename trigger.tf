resource "google_cloudbuild_trigger" "image_build" {
  name     = var.cloudbuild_trigger_name
  location = var.region

  repository_event_config {
    repository = google_cloudbuildv2_repository.my_repository.id
    push {
      branch = var.github_cloudbuild_repo_config.branch
    }
  }

  substitutions = {
    _REGION     = var.region
    _REPO       = var.artifact_registry
    _IMAGE_NAME = local.docker_image_name
  }

  filename        = var.cloudbuild_filename
  service_account = local.cloudbuild_trigger_sa
  depends_on      = [google_artifact_registry_repository.my_repo]
}

resource "google_cloudbuild_trigger" "cross_repo_image_build" {
  name     = local.trigger_name
  location = var.region

  repository_event_config {
    repository = google_cloudbuildv2_repository.my_repository.id
    push {
      branch = var.github_cloudbuild_repo_config.branch
    }
  }

  substitutions = {
    _REGION     = var.region
    _REPO       = var.artifact_registry
    _IMAGE_NAME = "${local.docker_image_name}-cross-repo"
  }

  filename        = var.cloudbuild_filename_cross_repo
  service_account = local.cloudbuild_trigger_sa
  depends_on      = [google_artifact_registry_repository.my_repo]
}
