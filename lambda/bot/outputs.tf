output "lambda_function_url" {
  value       = module.lambda_function.lambda_function_url
  sensitive   = false
  description = "Lambda function URL"
  depends_on  = [module.lambda_function]
}

output "lambda_function_invoke_arn" {
  value       = module.lambda_function.lambda_function_invoke_arn
  sensitive   = false
  description = "Lambda function invoke ARN"
  depends_on  = [module.lambda_function]
}

# output "api_gateway_base_url" {
#   value = aws_api_gateway_deployment.lambda_bot.invoke_url
#   sensitive   = false
#   description = "URL of the API gateway"
#   depends_on  = [aws_api_gateway_deployment.lambda]
# }
