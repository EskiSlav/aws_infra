variable "format" {
  type        = string
  default     = "$context.identity.sourceIp $context.identity.caller $context.identity.user [$context.requestTime] \"$context.httpMethod $context.resourcePath $context.protocol\" $context.status $context.responseLength $context.requestId $context.extendedRequestId"
  description = "Format string for cloudwatch logs"
}

variable "stage_name" {
  type        = string
  default     = "dev"
  description = "Stage name"
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "Region where resources located"
}

variable "function_name" {
  type        = string
  default     = "json_refiner"
  description = "Region where resources located"
}
