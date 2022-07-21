terraform {
  backend "s3" {
    bucket         = "uh-control-tf"
    key            = "infra/control/autosync-github"
    region         = "ca-central-1"
    dynamodb_table = "uh-control-file-state-dynamo"
    encrypt        = true
    profile        = "tf_state"
  }
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "github" {
  owner = "autosync-inc"
}
