variable "codepipeline_name" {}

variable "handler_implementation_dir" {
  description = "Location of directory that contains lambda function implementation. Usually something like '{path.module}/handler'"
}

variable "type" {
  default     = ""
  description = "Optional type differentiator that will be used to name "
}

variable "lambda_env_vars" {
  type        = map(string)
  description = "Additional environment variables to be passed to the Lambda function. Note: PIPELINE_NAME is always available."
  default     = {}
}

variable "dead_letter_sns_topic_arn" {
  default     = null
  description = "Optionally, you can specify a dead letter queue ARN to handle execution failures."
}

variable "execution_role_policies" {
  type        = list(string)
  default     = []
  description = "Optional list of policies to attach to the lambda function."
}

variable "eventbridge_rule" {
  type = object({
    name = string
    arn  = string
  })
  default = null
}

variable "runtime" {
  default     = "nodejs18.x"
  description = "See available runtimes here: https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html"
}

variable "memory_size" {
  default     = "128"
  description = "same as aws_lambda_function resource."
}

variable "timeout" {
  default     = "3"
  description = "same as aws_lambda_function resource."
}
