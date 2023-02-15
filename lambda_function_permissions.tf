resource "aws_lambda_permission" "cw_rule" {
  count         = var.eventbridge_rule == null ? 0 : 1
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trigger.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.eventbridge_rule.arn
}
