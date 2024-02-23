terraform {
  backend "s3" {
    bucket = "rain-cafe-ci"
    key    = "rain-cafe/orchestrator.tfstate"
    region = "ca-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}
