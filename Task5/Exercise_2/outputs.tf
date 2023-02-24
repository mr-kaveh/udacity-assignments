# TODO: Define the output variable for the lambda function.
output "function_arn" {
  description = "The ARN of the Lambda function"
  value = join("", aws_lambda_function.hd_udacity_lambda_function.*.arn)
}

output "function_invoke_arn" {
  description = "The Invoke ARN of the Lambda function"
  value = join("", aws_lambda_function.hd_udacity_lambda_function.*.invoke_arn)
}

output "function_name" {
  description = "The name of the Lambda function"
  value = join("", aws_lambda_function.hd_udacity_lambda_function.*.function_name)
}

output "function_qualified_arn" {
  description = "The qualified ARN of the Lambda function"
  value = join("", aws_lambda_function.hd_udacity_lambda_function.*.qualified_arn)
}
