resource "aws_lambda_function" "trigger" {
  filename         = local.handler_zip_name
  function_name    = local.function_name
  role             = aws_iam_role.lambda_service_role.arn
  handler          = "index.handler"
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  source_code_hash = data.archive_file.handler.output_base64sha256
  depends_on       = [data.archive_file.handler]

  environment {
    variables = merge(
      {
        PIPELINE_NAME = var.codepipeline_name
      },
      var.lambda_env_vars,
    )
  }

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_sns_topic_arn == null ? [] : [true]

    content {
      target_arn = var.dead_letter_sns_topic_arn
    }
  }
}
