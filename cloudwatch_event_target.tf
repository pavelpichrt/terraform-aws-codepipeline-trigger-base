resource "aws_cloudwatch_event_target" "pipeline_trigger" {
  count = var.eventbridge_rule == null ? 0 : 1
  rule  = var.eventbridge_rule.name
  arn   = aws_lambda_function.trigger.arn
}
