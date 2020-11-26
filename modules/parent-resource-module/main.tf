resource "aws_api_gateway_resource" "my_parent_resource" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_or_root_resource_id
  path_part   = var.endpoint_name
}
