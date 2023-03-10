resource "aws_lambda_layer_version" "openai" {
  filename   = "openai.zip"
  layer_name = "openai"

  source_code_hash = filebase64sha256("openai.zip")

  compatible_runtimes = ["python3.9"]
}
