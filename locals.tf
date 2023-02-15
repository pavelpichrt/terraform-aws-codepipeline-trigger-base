# This is to ensure uniqueness in names
resource "random_string" "name_unique_suffix" {
  length  = 6
  lower   = true
  special = false
  numeric = false
  upper   = false
}

locals {
  # Ensure a unique name with a maximum length of 64 chars (limit for a role or policy imposed by AWS)
  function_name    = "cp-trigger-${substr(var.codepipeline_name, -42, -1)}-${substr(var.type, 0, 3)}-${random_string.name_unique_suffix.result}"
  handler_zip_name = "${path.root}/tmp/handler${var.codepipeline_name}-${var.type}.zip"
}
