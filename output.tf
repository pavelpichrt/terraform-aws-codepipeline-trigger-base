output "lambda_function" {
  value = aws_lambda_function.trigger
}

output "lambda_service_role" {
  value = aws_iam_role.lambda_service_role
}
