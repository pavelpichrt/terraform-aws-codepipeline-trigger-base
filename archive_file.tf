data "archive_file" "handler" {
  type        = "zip"
  source_dir  = var.handler_implementation_dir
  output_path = local.handler_zip_name
}
