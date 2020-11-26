resource "aws_api_gateway_authorizer" "MyAuthorizer" {
  name                   = "MyAuthorizer"
  rest_api_id            = aws_api_gateway_rest_api.sample_api.id
  authorizer_uri         = var.authorizer_lambda_invoke_arn
  authorizer_credentials = aws_iam_role.invocation_role.arn
}

resource "aws_iam_role" "invocation_role" {
  name = "api_gateway_auth_invocation"
  path = "/"

  assume_role_policy = jsonencode(
    {
      Version : "2012-10-17",
      Statement : [
        {
          Action : "sts:AssumeRole",
          Principal : {
            Service : "apigateway.amazonaws.com"
          },
          Effect : "Allow",
          Sid : ""
        }
      ]
  })
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "default"
  role = aws_iam_role.invocation_role.id

  policy = jsonencode(
    {
      Version : "2012-10-17",
      Statement : [
        {
          Action : "lambda:InvokeFunction",
          Effect : "Allow",
          Resource : var.authorizer_lambda_arn
        }
      ]
  })
}
