locals {
  cloudbuild_github_connection_name = "dev-github-connection"
  cloudbuild_trigger_sa             = "projects/${var.project}/serviceAccounts/${var.cloudbuild_trigger_sa}"
  docker_image_name                 = "my-test-image"
  trigger_name                      = "${var.cloudbuild_trigger_name}-cross-repo"
}
