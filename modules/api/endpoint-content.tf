
module "Parent_Content" {
  source                     = "../parent-resource-module"
  endpoint_name              = "content"
  parent_or_root_resource_id = aws_api_gateway_rest_api.sample_api.root_resource_id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
}

module "Parent_Content_Detail" {
  source                     = "../parent-resource-module"
  endpoint_name              = "detail"
  parent_or_root_resource_id = module.Parent_Content.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
}

module "detail_collector" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_Content_Detail.id
  endpoint_name              = "{proxy+}"
  endpoint_url               = "http://34.248.86.167/api/content/{proxy}"
  use_proxy_parameter        = true
}
