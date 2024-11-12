resource "google_secret_manager_secret" "github_token_secret" {
  project   = var.project
  secret_id = var.secret_name

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "github_token_secret" {
  secret      = google_secret_manager_secret.github_token_secret.id
  secret_data = var.github_pat_secret
}


data "google_iam_policy" "serviceagent_secretAccessor" {
  binding {
    role    = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:${var.sa_serviceagent_secretAccessor}", "serviceAccount:${var.cloudbuild_trigger_sa}"]
  }
}

resource "google_secret_manager_secret_iam_policy" "policy" {
  project     = google_secret_manager_secret.github_token_secret.project
  secret_id   = google_secret_manager_secret.github_token_secret.secret_id
  policy_data = data.google_iam_policy.serviceagent_secretAccessor.policy_data
}


# Create the GitHub connection
resource "google_cloudbuildv2_connection" "my_connection" {
  project  = var.project
  location = var.region
  name     = local.cloudbuild_github_connection_name

  github_config {
    app_installation_id = var.github_app_installation_id
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github_token_secret.id
    }
  }
  depends_on = [google_secret_manager_secret_iam_policy.policy]
}

resource "google_cloudbuildv2_repository" "my_repository" {
  name              = var.github_cloudbuild_repo_config.repo
  location          = var.region
  parent_connection = google_cloudbuildv2_connection.my_connection.name
  remote_uri        = var.github_cloudbuild_repo_config.url
}
