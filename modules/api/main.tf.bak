resource "aws_api_gateway_rest_api" "sample_api" {
  name = var.agw_restapi_name
  endpoint_configuration {
    types = var.endpoint_configuration_types
  }
}

resource "aws_api_gateway_resource" "mock" {
  rest_api_id = aws_api_gateway_rest_api.sample_api.id
  parent_id   = aws_api_gateway_rest_api.sample_api.root_resource_id
  path_part   = var.agw_resource_path_part
}

resource "aws_api_gateway_method" "mock_any_method" {
  rest_api_id   = aws_api_gateway_rest_api.sample_api.id
  resource_id   = aws_api_gateway_resource.mock.id
  http_method   = var.agw_method_http_method
  authorization = var.agw_method_authorization
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.apple_signature_api.id
  resource_id             = aws_api_gateway_resource.apple_signature_offer_resource.id
  http_method             = aws_api_gateway_method.apple_signature_post_method.http_method
  integration_http_method = var.agw_integration_http_method
  type                    = var.agw_integration_type
  uri                     = var.lambda_invoke_arn
}

resource "aws_lambda_permission" "apple_signature_lambda_permission" {
  statement_id  = var.lambda_permission_statement_id
  action        = var.lambda_permission_action
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = join("", [var.arn_prefix, ":${aws_api_gateway_rest_api.apple_signature_api.id}/*/${aws_api_gateway_method.apple_signature_post_method.http_method}${aws_api_gateway_resource.apple_signature_offer_resource.path}"])
}

resource "aws_api_gateway_deployment" "apple_signature_test_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.apple_signature_api.id
  stage_name  = var.agw_stage_name
}

#resource "aws_api_gateway_stage" "apple_signature_test_stage" {
#  stage_name    = var.agw_stage_name
#  rest_api_id   = aws_api_gateway_rest_api.apple_signature_api.id
#  deployment_id = aws_api_gateway_deployment.apple_signature_test_deployment.id
#}