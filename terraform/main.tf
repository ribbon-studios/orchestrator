terraform {
  backend "s3" {
    bucket = "rain-cafe-ci"
    key    = "rain-cafe/orchestrator.tfstate"
    region = "ca-central-1"
  }

  # NOTE: We can't utilize the terraform provider for namecheap
  # This is due to namecheap having a whitelist for their api of allowed ips
  # GitHub Actions uses a massive list of CIDRs for its IPs so its not
  # feasible to whitelist them all
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"

  default_tags {
    tags = {
      slug = "rain-cafe/orchestrator"
      repo = "https://github.com/rain-cafe/orchestrator"
    }
  }
}
