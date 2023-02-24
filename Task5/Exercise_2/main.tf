# Define AWS provider
provider "aws" {
  region = var.aws_region # Reading From variables.tf
  access_key = "ASIAVAR2LBDWOPMBAYPR"
  secret_key = "Oo5PbaXxCH5avR2mc40DeC0IOomABrxhZ4Gvttrb"
  token = "FwoGZXIvYXdzEHgaDBRBMTfQcV6OnAlDXSLVAQw3k3NooYKckekaZOhfD5Wg56Zo6Rs/0CmKU1RZqjnZU748k5wVb9rQaBC4RvRM7lZestfVNn43pACvo4ZVdf2y4ua0wRPPub+RdOXai/D2qLa0TfQ5UTO7wDWv7VyWTp1FHVMr3JKKObbwymyCr2/InxrgfAyWnFjx4XK/RoeGNyU5oFMSpbMTWZKpHgEkWvY9193hHABZTU1qMNAPjnsjIr+RT5bg7VX3JrRHMuRglqhv8eBUmoQKCg+DlT1P1ESmF02kp4gi9hLriszGDGoKvjhKvCioq+GfBjItIJDAMJwIW3AlIBgaHAbH4UYKks/ChvH2TPyXZKncZgyD8UbfDmak3BMNs1dc"
}

# Create a new Lambda function
resource "aws_lambda_function" "hd_udacity_lambda_function" {
  function_name = "hd-lambda-function"
  handler = "lambda.lambda_handler"
  runtime = "python3.9"
  role = aws_iam_role.lambda_role.arn
  filename = "lambda.zip"
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.lambda_role.name
}

resource "aws_cloudwatch_log_group" "hd-cloudwatch" {
  name = "/aws/lambda/hd-lambda-function"
  retention_in_days = 7
  tags = {
    Application = "lambda_function"
  }
}