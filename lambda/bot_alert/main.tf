module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = "Telegram Compliment Bot default handler of messages"
  handler       = "lambda_handler.lambda_handler"
  runtime       = "python3.9"
  timeout       = 15
  # publish       = true

  attach_cloudwatch_logs_policy = true

  create_role = false
  lambda_role = aws_iam_role.lambda_role.arn

  source_path = [
    {
      path             = "../../../compliment_bot_alert/bot",
      pip_requirements = false,
      patterns = [
        "!.mypy_cache/.*", # Skip all txt files recursively
        "!.*/__pycache__/.*",
        "!.git/.*",
        "!.pre-commit-config.yaml",
        "!.gitignore",
        "!.DS_Store",
      ]
    }
  ]

  layers = [
    data.terraform_remote_state.lambda_layers.outputs.openai_layer_arn,
  ]
}

resource "aws_iam_policy" "lambda_bot_policy" {
  name        = "${var.function_name}Policy"
  path        = "/"
  description = "Allow access to SSM"

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
