output "bot_api_token_arn" {
  value       = aws_ssm_parameter.bot_api_token.arn
  sensitive   = true
  description = "ARN of bot token"
  depends_on  = [aws_ssm_parameter.bot_api_token]
}
