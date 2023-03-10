variable "function_name" {
  type        = string
  default     = "bot_alert"
  description = "The name of the function"
}

# variable "format" {
#   type        = string
#   default     = "$context.identity.sourceIp $context.identity.caller $context.identity.user [$context.requestTime] \"$context.httpMethod $context.resourcePath $context.protocol\" $context.status $context.responseLength $context.requestId $context.extendedRequestId"
#   description = "Format string for cloudwatch logs"
# }

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "Region where resources located"
}
