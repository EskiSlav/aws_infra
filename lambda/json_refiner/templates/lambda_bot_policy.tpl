{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetParameter"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:${region}:${account_id}:parameter/config/json_refiner/*",
        "arn:aws:ssm:${region}:${account_id}:parameter/config/json_refiner/api_token"
      ]
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
    }
  ]
}
