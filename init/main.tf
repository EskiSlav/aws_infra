resource "aws_s3_bucket" "terraform_state" {
  bucket = "compliment-bot-terraform-state"
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}


module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name        = "terraform-lock"
  hash_key    = "LockID"
  table_class = "STANDARD_INFREQUENT_ACCESS"

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  tags = {
    Terraform = "true"
  }
}