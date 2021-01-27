
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

}

resource "aws_lambda_function" "lambda" {
  filename      = "${path.module}/files/app.zip"
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = var.function_handler

  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = data.archive_file.app.output_base64sha256

  runtime = "nodejs12.x"
}

resource "aws_iam_role" "lambda" {
  name = "${var.function_name}EndpointFunctionRole"

  assume_role_policy = jsonencode(
    {
      Version : "2012-10-17",
      Statement : [
        {
          Action : "sts:AssumeRole",
          Principal : {
            "Service" : [
              "lambda.amazonaws.com"
            ]
          },
          Effect : "Allow",
          Sid : ""
        }
      ]
  })
}
