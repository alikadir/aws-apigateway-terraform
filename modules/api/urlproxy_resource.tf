resource "aws_api_gateway_resource" "urlproxy" {
  rest_api_id = aws_api_gateway_rest_api.sample_api.id
  parent_id   = aws_api_gateway_rest_api.sample_api.root_resource_id
  path_part   = "urlproxy"
}

resource "aws_api_gateway_method" "urlproxy_any_method" {
  rest_api_id   = aws_api_gateway_rest_api.sample_api.id
  resource_id   = aws_api_gateway_resource.urlproxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "urlproxy_any_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sample_api.id
  resource_id             = aws_api_gateway_resource.urlproxy.id
  http_method             = aws_api_gateway_method.urlproxy_any_method.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://jsonplaceholder.typicode.com/users"
}


resource "aws_api_gateway_method_response" "urlproxy_any_method_response" {
  rest_api_id = aws_api_gateway_rest_api.sample_api.id
  resource_id = aws_api_gateway_resource.urlproxy.id
  http_method = aws_api_gateway_method.urlproxy_any_method.http_method
  status_code = "200"
  response_models = {
        "application/json" = "Empty"
    }
}

resource "aws_api_gateway_method" "urlproxy_options_method" {
  rest_api_id   = aws_api_gateway_rest_api.sample_api.id
  resource_id   = aws_api_gateway_resource.urlproxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "urlproxy_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sample_api.id
  resource_id             = aws_api_gateway_resource.urlproxy.id
  http_method             = aws_api_gateway_method.urlproxy_options_method.http_method
  type                    = "MOCK"
}

resource "aws_api_gateway_integration_response" "urlproxy_options_integration_response" {
    rest_api_id = aws_api_gateway_rest_api.sample_api.id
    resource_id = aws_api_gateway_resource.urlproxy.id
    http_method = aws_api_gateway_method.urlproxy_options_method.http_method
    status_code = 200

    response_templates = {
            "application/json" = <<EOF
        EOF
        }

    response_parameters = { 
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
        "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
     }
}

resource "aws_api_gateway_method_response" "urlproxy_options_method_response" {
    rest_api_id = aws_api_gateway_rest_api.sample_api.id
    resource_id = aws_api_gateway_resource.urlproxy.id
    http_method = aws_api_gateway_method.urlproxy_options_method.http_method
    status_code = "200"
    response_models = {
            "application/json" = "Empty"
        }
    response_parameters = { 
        "method.response.header.Access-Control-Allow-Headers" = true
        "method.response.header.Access-Control-Allow-Methods" = true
        "method.response.header.Access-Control-Allow-Origin" = true
     }
}

