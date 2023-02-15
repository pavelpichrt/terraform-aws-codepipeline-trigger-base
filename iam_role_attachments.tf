resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.lambda_service_role.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}

resource "aws_iam_role_policy_attachment" "lambda_execution_custom" {
  count = length(var.execution_role_policies)

  role       = aws_iam_role.lambda_service_role.name
  policy_arn = aws_iam_policy.lambda_execution_custom[count.index].arn
}
