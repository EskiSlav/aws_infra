output "bot_api_token_arn" {
  value       = aws_ssm_parameter.bot_api_token.arn
  sensitive   = false
  description = "ARN of bot token"
  depends_on  = [aws_ssm_parameter.bot_api_token]
}

output "openai_api_token_arn" {
  value       = aws_ssm_parameter.openai_api_token.arn
  sensitive   = false
  description = "ARN of openai token"
  depends_on  = [aws_ssm_parameter.openai_api_token]
}
