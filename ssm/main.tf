resource "aws_ssm_parameter" "bot_api_token" {
  name  = "/config/bot/api_token"
  type  = "SecureString"
  value = "replace_me!"
}

resource "aws_ssm_parameter" "openai_api_token" {
  name  = "/config/bot/openai_api_token"
  type  = "SecureString"
  value = "replace_me!"
}
