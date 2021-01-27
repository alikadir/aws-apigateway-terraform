resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_or_root_resource_id
  path_part   = var.endpoint_name
}

resource "aws_api_gateway_method" "my_resource_any_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "my_resource_http_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.my_resource.id
  http_method             = aws_api_gateway_method.my_resource_any_method.http_method
  integration_http_method = "ANY"
  type                    = "AWS_PROXY" //Use HTTP Proxy integration
  uri                     = var.function_arn


}



