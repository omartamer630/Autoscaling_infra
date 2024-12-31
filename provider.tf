terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  cloud {

    organization = "terraform_project_01"

    workspaces {
      name = "dev"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
