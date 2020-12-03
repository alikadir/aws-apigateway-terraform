
resource "aws_api_gateway_deployment" "dev_deployment" {
  rest_api_id = module.API.rest_api_id
}

resource "aws_api_gateway_stage" "dev_stage" {
  deployment_id = aws_api_gateway_deployment.dev_deployment.id
  rest_api_id   = module.API.rest_api_id
  stage_name    = "dev"
}

resource "aws_api_gateway_method_settings" "settings" {
  rest_api_id = module.API.rest_api_id
  stage_name  = aws_api_gateway_stage.dev_stage.stage_name
  method_path = "*/*"
  settings {
    logging_level      = "ERROR"
    data_trace_enabled = true
  }
}
