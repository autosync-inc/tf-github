locals {
  common_attributes = {
    description            = "TF managed repo."
    features               = []
    topics                 = []
    delete_branch_on_merge = false
    visibility             = "private"
    archive_on_destroy     = true
    vulnerability_alerts   = true
    homepage_url           = ""
    is_template            = false
    allow_merge_commit     = true
    allow_squash_merge     = true
    allow_rebase_merge     = true
    allow_auto_merge       = false
    archived               = false

  }
  repositories = {
    ds_web_components = merge(local.common_attributes, {
      name         = "design-system-web-components"
      description  = "Enjoy Seamless Integration of Reusable Web-Components | Simply Plug and use"
      homepage_url = "https://zeroheight.com/180f285a2/p/64e786-our-objective"
      topics = [
        "autosync",
        "web-components"
      ]
    })
    ds_icons = merge(local.common_attributes, {
      name        = "design-system-icons"
      description = "All the icons , simply install and use"
    })
  }
}

resource "github_repository" "autosync" {
  for_each               = local.repositories
  name                   = each.value["name"]
  description            = each.value["description"]
  has_downloads          = contains(each.value["features"], "has_downloads") ? true : false
  has_projects           = contains(each.value["features"], "has_projects") ? true : false
  has_issues             = contains(each.value["features"], "has_issues") ? true : false
  has_wiki               = contains(each.value["features"], "has_wiki") ? true : false
  topics                 = each.value["topics"]
  visibility             = each.value["visibility"]
  delete_branch_on_merge = each.value["delete_branch_on_merge"]
  archive_on_destroy     = each.value["archive_on_destroy"]
  vulnerability_alerts   = each.value["vulnerability_alerts"]
  homepage_url           = each.value["homepage_url"]
  is_template            = each.value["is_template"]
  allow_merge_commit     = each.value["allow_merge_commit"]
  allow_squash_merge     = each.value["allow_squash_merge"]
  allow_rebase_merge     = each.value["allow_rebase_merge"]
  allow_auto_merge       = each.value["allow_auto_merge"]
  archived               = each.value["archived"]
}

output "autosync_repos" {
  value = { for k, v in github_repository.autosync : k => v.ssh_clone_url }
}
