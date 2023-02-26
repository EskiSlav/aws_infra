terraform {
    required_version = ">= 1.3.7"
    
    backend "s3" {
      bucket = "compliment-bot-terraform-state"
      key    = "lambda/bot/terraform.tfstate" 
      region = "us-east-1"
      dynamodb_table = "terraform-lock"
    }
}