resource "aws_iam_role" "lambda_service_role" {
  name = local.function_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = {
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
  })
}
