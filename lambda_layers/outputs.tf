output "openai_layer_arn" {
  value       = aws_lambda_layer_version.openai.arn
  sensitive   = false
  description = "ARN of the layer for OpenAI SDK"
  depends_on  = [aws_lambda_layer_version.openai]
}
