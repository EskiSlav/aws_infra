
resource "aws_api_gateway_rest_api" "lambda_bot" {
  name        = "bot"
  description = "Lambda Compliment Bot"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "lambda_bot" {
  rest_api_id = aws_api_gateway_rest_api.lambda_bot.id
  parent_id   = aws_api_gateway_rest_api.lambda_bot.root_resource_id
  path_part   = var.function_name
}

resource "aws_api_gateway_integration" "lambda_bot_post" {
  rest_api_id             = aws_api_gateway_rest_api.lambda_bot.id
  resource_id             = aws_api_gateway_resource.lambda_bot.id
  http_method             = aws_api_gateway_method.lambda_bot_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_function.lambda_function_invoke_arn
}

resource "aws_api_gateway_integration" "lambda_bot_get" {
  rest_api_id             = aws_api_gateway_rest_api.lambda_bot.id
  resource_id             = aws_api_gateway_resource.lambda_bot.id
  http_method             = aws_api_gateway_method.lambda_bot_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_function.lambda_function_invoke_arn
}

resource "aws_api_gateway_deployment" "lambda_bot" {
  rest_api_id = aws_api_gateway_rest_api.lambda_bot.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.lambda_bot.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_method.lambda_bot_post,
    aws_api_gateway_method.lambda_bot_get,
    aws_api_gateway_integration.lambda_bot_get,
  ]
}

resource "aws_api_gateway_stage" "lambda_bot_dev" {
  deployment_id = aws_api_gateway_deployment.lambda_bot.id
  rest_api_id   = aws_api_gateway_rest_api.lambda_bot.id
  stage_name    = var.stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway.arn
    format          = var.format
  }

  depends_on = [aws_cloudwatch_log_group.api_gateway, aws_api_gateway_account.api_gateway]
}

resource "aws_api_gateway_method" "lambda_bot_post" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_bot.id
  resource_id   = aws_api_gateway_resource.lambda_bot.id
  http_method   = "POST"
  authorization = "NONE"
}
resource "aws_api_gateway_method" "lambda_bot_get" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_bot.id
  resource_id   = aws_api_gateway_resource.lambda_bot.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_account" "api_gateway" {
  cloudwatch_role_arn = aws_iam_role.api_gateway.arn
}

resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.lambda_bot.id}/${var.stage_name}"
  retention_in_days = 7
}

resource "aws_iam_role" "api_gateway" {
  name               = "apiGatewayLogs"
  assume_role_policy = data.template_file.lambda_bot_assume_role.rendered
}

resource "aws_iam_policy_attachment" "api_gateway_push_logs_attach" {
  name       = "api_gateway_push_logs_attach"
  roles      = [aws_iam_role.api_gateway.name]
  policy_arn = data.aws_iam_policy.push_to_cloudwatch.arn
}
