resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_or_root_resource_id
  path_part   = var.endpoint_name
}

resource "aws_api_gateway_method" "my_resource_any_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = var.authorizer_id
}

resource "aws_api_gateway_integration" "my_resource_any_method_integration" {
  rest_api_id       = var.rest_api_id
  resource_id       = aws_api_gateway_resource.my_resource.id
  http_method       = aws_api_gateway_method.my_resource_any_method.http_method
  type              = "MOCK"
  request_templates = { "application/json" = jsonencode({ statusCode = 200 }) }
  depends_on        = [aws_api_gateway_method.my_resource_any_method]
}

resource "aws_api_gateway_integration_response" "my_resource_any_method_integration_response" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.my_resource_any_method.http_method
  depends_on  = [aws_api_gateway_integration.my_resource_any_method_integration]
  status_code = 200
  response_templates = {
    "application/json" = var.response
  }
}

resource "aws_api_gateway_method_response" "my_resource_any_method_response" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.my_resource_any_method.http_method
  depends_on  = [aws_api_gateway_integration_response.my_resource_any_method_integration_response]
  status_code = 200
  response_models = {
    "application/json" = "Empty"
  }
}
/*
resource "aws_api_gateway_method" "mock_options_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "mock_options_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.mock_options_method.http_method
  type        = "MOCK"
  depends_on  = [aws_api_gateway_method.mock_options_method]
}

resource "aws_api_gateway_integration_response" "mock_options_integration_response" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.mock_options_method.http_method
  status_code = 200
  depends_on  = [aws_api_gateway_integration.mock_options_integration]

  response_templates = {
    "application/json" = <<EOF
        EOF
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

resource "aws_api_gateway_method_response" "mock_options_method_response" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.mock_options_method.http_method
  depends_on  = [aws_api_gateway_integration_response.mock_options_integration_response]
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}
*/
