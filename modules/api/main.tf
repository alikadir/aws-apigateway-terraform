resource "aws_api_gateway_rest_api" "sample_api" {
  name = var.agw_restapi_name
  endpoint_configuration {
    types = var.endpoint_configuration_types
  }
}
