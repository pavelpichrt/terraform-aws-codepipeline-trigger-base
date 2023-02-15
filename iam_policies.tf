data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "lambda_execution" {
  statement {
    effect = "Allow"
    actions = [
      "codepipeline:StartPipelineExecution"
    ]
    resources = ["arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.codepipeline_name}"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
    ]

    resources = [
      aws_cloudwatch_log_group.lambda_log_group.arn,
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
    ]
    resources = [
      "${aws_cloudwatch_log_group.lambda_log_group.arn}:*",
    ]
  }

  dynamic "statement" {
    for_each = var.dead_letter_sns_topic_arn == null ? [] : [true]

    content {
      effect = "Allow"
      actions = [
        "sns:Publish",
      ]
      resources = [
        var.dead_letter_sns_topic_arn,
      ]
    }
  }
}

resource "aws_iam_policy" "lambda_execution" {
  name   = "lambda-${local.function_name}"
  policy = data.aws_iam_policy_document.lambda_execution.json
}

resource "aws_iam_policy" "lambda_execution_custom" {
  count = length(var.execution_role_policies)

  name   = "lambda-${local.function_name}-${count.index}"
  policy = var.execution_role_policies[count.index]
}
