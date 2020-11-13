
data "archive_file" "app" {
  type        = "zip"
  output_path = "${path.module}/files/app.zip"
  #excludes    = [ "${path.module}/unwanted.zip" ]
  source_dir = "app/"
}