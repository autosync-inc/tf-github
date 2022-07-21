locals {
  users = setunion([
    "schiller-j",
    "KapoorHemant"
  ])
}

data "github_user" "autosync" {
  for_each = local.users
  username = each.value
}

resource "github_branch_protection" "ds_web_components_main" {
  repository_id = github_repository.autosync["ds_web_components"].node_id

  pattern          = "main"
  enforce_admins   = false
  allows_deletions = false
  blocks_creations = true

  push_restrictions = [
    data.github_user.autosync["schiller-j"].node_id,
    data.github_user.autosync["KapoorHemant"].node_id
  ]
}


resource "github_branch_protection" "ds_web_components_develop" {
  repository_id = github_repository.autosync["ds_web_components"].node_id

  pattern          = "develop"
  enforce_admins   = false
  allows_deletions = false
  blocks_creations = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    dismissal_restrictions          = []
    pull_request_bypassers          = []
    require_code_owner_reviews      = false
    required_approving_review_count = 1
    restrict_dismissals             = false
  }

  required_status_checks {
    contexts = ["ci"]
    strict   = true
  }
}

resource "github_branch_protection" "ds_icons_main" {
  repository_id = github_repository.autosync["ds_icons"].node_id

  pattern          = "main"
  enforce_admins   = false
  allows_deletions = false
  blocks_creations = true

  push_restrictions = [
    data.github_user.autosync["schiller-j"].node_id,
    data.github_user.autosync["KapoorHemant"].node_id
  ]
}


resource "github_branch_protection" "ds_icons_develop" {
  repository_id = github_repository.autosync["ds_icons"].node_id

  pattern          = "develop"
  enforce_admins   = false
  allows_deletions = false
  blocks_creations = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    dismissal_restrictions          = []
    pull_request_bypassers          = []
    require_code_owner_reviews      = false
    required_approving_review_count = 1
    restrict_dismissals             = false
  }
}
