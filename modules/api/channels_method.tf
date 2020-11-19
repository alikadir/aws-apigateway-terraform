resource "aws_api_gateway_resource" "channels" {
  rest_api_id = aws_api_gateway_rest_api.sample_api.id
  parent_id   = aws_api_gateway_rest_api.sample_api.root_resource_id
  path_part   = "channelscurrentprogram"
}

resource "aws_api_gateway_method" "channels_any_method" {
  rest_api_id   = aws_api_gateway_rest_api.sample_api.id
  resource_id   = aws_api_gateway_resource.channels.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.MyAuthorizer.id
}

resource "aws_api_gateway_integration" "channel_http_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sample_api.id
  resource_id             = aws_api_gateway_resource.channels.id
  http_method             = aws_api_gateway_method.channels_any_method.http_method
  integration_http_method = "ANY"
  type                    = "HTTP"
  uri                     = "http://api-worker-tvguide.digiturk.com.tr/api/channelsCurrentProgram"
}

resource "aws_api_gateway_integration_response" "channel_http_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.sample_api.id
  resource_id = aws_api_gateway_resource.channels.id
  http_method = aws_api_gateway_method.channels_any_method.http_method
  status_code = 200

  response_templates = {
        "application/json" = <<EOF
    EOF
    }
}

resource "aws_api_gateway_method_response" "channel_http_method_response" {
  rest_api_id = aws_api_gateway_rest_api.sample_api.id
  resource_id = aws_api_gateway_resource.channels.id
  http_method = aws_api_gateway_method.channels_any_method.http_method
  status_code = "200"
  response_models = {
        "application/json" = "Empty"
    }
}

resource "aws_api_gateway_method" "channels_options_method" {
  rest_api_id   = aws_api_gateway_rest_api.sample_api.id
  resource_id   = aws_api_gateway_resource.channels.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "channel_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sample_api.id
  resource_id             = aws_api_gateway_resource.channels.id
  http_method             = aws_api_gateway_method.channels_options_method.http_method
  type                    = "MOCK"
}

resource "aws_api_gateway_integration_response" "channel_options_integration_response" {
    rest_api_id = aws_api_gateway_rest_api.sample_api.id
    resource_id = aws_api_gateway_resource.channels.id
    http_method = aws_api_gateway_method.channels_options_method.http_method
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

resource "aws_api_gateway_method_response" "channel_options_method_response" {
    rest_api_id = aws_api_gateway_rest_api.sample_api.id
    resource_id = aws_api_gateway_resource.channels.id
    http_method = aws_api_gateway_method.channels_options_method.http_method
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