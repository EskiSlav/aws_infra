# aws_infra
This repository represents the infrastructure for my personal AWS cloud

## Contents
- DynamoDB Tables
  - compliments: table for the compliments for my Telegram Bot;
  - users: table where telegram users are stored;
- Lambda. Contains 3 lambda functions. Every lambda is connected to my TG Bots.
  - bot_alert: Lambda which is triggered by cron and sends users compliments;
  - bot: Lambda that processes all incoming messages;
  - json_refiner: a bot that formats "Python Dict" to standard JSON format;
- Lambda Layers: so that one layer could be reused inside all my lambda functions;
- Security Groups
- SSM
- VPC

## How to Apply
To apply all of the resources you need to apply them in particular order:
1. init
2. VPC
3. Security Groups
4. Lambda Layers
5. DynamoDB
6. Lambda

## Lambda
To deploy lambda functions it is needed to have them locally near the "aws_infra" repository.
In the future, it will be changed to something more convenient.
