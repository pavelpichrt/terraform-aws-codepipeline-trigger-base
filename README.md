# AWS Codepipeline Trigger (base)

A base module for implementation of a custom Codepipeline trigger via a Lambda function.

## Usage

```terraform
data "aws_iam_policy_document" "lambda_execution_custom" {
  statement {
    effect = "Allow"
    actions = [
      "codecommit:GetCommit"
    ]
    resources = ["<codecommit_repo_arn>"]
  }
}

resource "aws_cloudwatch_event_rule" "pipeline_trigger" {
  name        = "pipeline-trigger-my-pipeline"
  description = "Triggers the deployment pipeline 'my-pipeline'"

  event_pattern = jsonencode({
    detail = {
      event = [
        "referenceCreated",
        "referenceUpdated",
      ]
      referenceName = ["master"]
      referenceType = ["branch"]
    }
    detail-type = [
      "CodeCommit Repository State Change",
    ]
    resources = [
      "<repo_arn>",
    ]
    source = [
      "aws.codecommit",
    ]
  })
}

module "cp_trigger_base" {
  source = "pavelpichrt/codepipeline-trigger-base/aws"

  type                 = "codecommit"
  codepipeline_name    = "my-pipeline"
  trigger_branch       = var.trigger_branch
  handler_zip_dir      = "${path.module}/handler"
  eventbridge_rule     = aws_cloudwatch_event_rule.pipeline_trigger

  lambda_execution_policy_docs_custom = [
    data.aws_iam_policy_document.lambda_execution_custom.json,
  ]
}
```
