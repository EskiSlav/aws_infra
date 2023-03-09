module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = "Telegram Compliment Bot default handler of messages"
  handler       = "lambda_handler.lambda_handler"
  runtime       = "python3.9"
  # publish       = true

  attach_cloudwatch_logs_policy = true

  create_role = false
  lambda_role = aws_iam_role.lambda_role.arn

  source_path = [
    {
      path             = "../../../compliment_bot/bot",
      pip_requirements = true,
      patterns = [
        "!.mypy_cache/.*", # Skip all txt files recursively
        "!__pycache__",
        "!.git/.*",
        "!.pre-commit-config.yaml",
        "!.gitignore",
      ]
    }
  ]

  # allowed_triggers = {
  #   APIGatewayAny = {
  #     service    = "apigateway"
  #     source_arn = aws_api_gateway_deployment.lambda_bot.execution_arn
  #   },
  # }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.lambda_bot.execution_arn}/*/*"
}

resource "aws_iam_policy" "lambda_bot_policy" {
  name        = "${var.function_name}Policy"
  path        = "/"
  description = "Allow access to SSM"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = data.template_file.lambda_bot_policy.rendered
}

resource "aws_iam_role" "lambda_role" {
  name               = var.function_name
  assume_role_policy = data.template_file.lambda_bot_assume_role.rendered
}

resource "aws_iam_policy_attachment" "labmda_policy_attach" {
  name       = "labmda_policy_attach"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.lambda_bot_policy.arn
}
