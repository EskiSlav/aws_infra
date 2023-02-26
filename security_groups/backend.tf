terraform {
  required_version = ">= 1.3.7"

  required_providers {
    aws = {
      version = "~> 4.56.0"
    }
  }

  backend "s3" {
    bucket         = "compliment-bot-terraform-state"
    key            = "security_groups/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
