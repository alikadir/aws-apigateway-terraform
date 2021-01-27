data "archive_file" "app" {
  type        = "zip"
  output_path = "${path.module}/files/app.zip"
  source_dir  = var.function_source_path
}
