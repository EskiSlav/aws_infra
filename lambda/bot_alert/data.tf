data "aws_caller_identity" "current" {}

data "terraform_remote_state" "lambda_layers" {
  backend = "s3"

  config = {
    bucket = "compliment-bot-terraform-state"
    key    = "lambda_layers/bot/terraform.tfstate"
    region = "eu-west-2"
  }
}

data "terraform_remote_state" "compliments_dynamodb" {
  backend = "s3"

  config = {
    bucket = "compliment-bot-terraform-state"
    key    = "dynamodb/compliments/terraform.tfstate"
    region = "eu-west-2"
  }
}

data "terraform_remote_state" "users_dynamodb" {
  backend = "s3"

  config = {
    bucket = "compliment-bot-terraform-state"
    key    = "dynamodb/users/terraform.tfstate"
    region = "eu-west-2"
  }
}

data "template_file" "lambda_bot_policy" {
  template = file("${path.module}/templates/lambda_bot_policy.tpl")
  vars = {
    function_arn               = module.lambda_function.lambda_function_arn
    account_id                 = data.aws_caller_identity.current.account_id
    region                     = var.region
    functionname               = var.function_name
    compliments_dynamodb_table = data.terraform_remote_state.compliments_dynamodb.outputs.dynamodb_table_arn
    users_dynamodb_table       = data.terraform_remote_state.users_dynamodb.outputs.dynamodb_table_arn
  }
}

data "template_file" "lambda_bot_assume_role" {
  template = file("${path.module}/templates/lambda_bot_assume_role.tpl")
}
