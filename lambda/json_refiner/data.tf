data "aws_caller_identity" "current" {}

data "template_file" "lambda_bot_policy" {
  template = file("${path.module}/templates/lambda_bot_policy.tpl")
  vars = {
    function_arn = module.lambda_function.lambda_function_arn
    account_id   = data.aws_caller_identity.current.account_id
    region       = var.region
    functionname = var.function_name
  }
}

data "template_file" "lambda_bot_assume_role" {
  template = file("${path.module}/templates/lambda_bot_assume_role.tpl")
}


data "aws_iam_policy" "push_to_cloudwatch" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}
