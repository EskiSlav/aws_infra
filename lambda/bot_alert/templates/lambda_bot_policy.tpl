{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetParameter"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:ssm:${region}:${account_id}:parameter/config/bot/*"
    },
    {
      "Action": [
        "lambda:InvokeAsync",
        "lambda:InvokeFunction"
      ],
      "Effect": "Allow",
      "Resource": "${function_arn}"
    },
    {
      "Action": [
        "translate:TranslateText"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": "logs:CreateLogGroup",
        "Resource": "arn:aws:logs:${region}:${account_id}:*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": [
            "arn:aws:logs:${region}:${account_id}:log-group:/aws/lambda/${functionname}:*"
        ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "dynamodb:*"
        ],
        "Resource": [
            "${compliments_dynamodb_table}",
            "${users_dynamodb_table}"
        ]
    }
  ]
}
