resource "aws_lambda_function" "lambda" {
    #s3_bucket       = var.bucket_name
    #s3_key          = var.key
    filename = "${path.module}/files/app.zip"
    function_name   = var.function_name
    role            = var.role_arn
    handler         = var.function_handler
    #timeout         = var.function_timeout

    # The filebase64sha256() function is available in Terraform 0.11.12 and later
    # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
    # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
    source_code_hash = data.archive_file.app.output_base64sha256

    runtime = "nodejs12.x"

    #vpc_config {                                uncomment this block if you need to access internal AWS resources
    #    subnet_ids         = [""]
    #    security_group_ids = [""]
    #}
  
}