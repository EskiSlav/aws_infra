module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "users"
  hash_key = "id"

  attributes = var.attributes

  tags = {
    Terraform   = "true"
    Environment = "development"
  }
}