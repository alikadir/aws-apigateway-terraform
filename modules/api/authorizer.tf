resource "aws_api_gateway_authorizer" "MyAuthorizer" {
  name                   = "MyAuthorizer"
  rest_api_id            = aws_api_gateway_rest_api.sample_api.id
  authorizer_uri         = var.authorizer_lambda_invoke_arn
}
