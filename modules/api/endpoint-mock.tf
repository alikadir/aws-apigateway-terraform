module "Parent_Mock" {
  source                     = "../parent-resource-module"
  endpoint_name              = "mock"
  parent_or_root_resource_id = aws_api_gateway_rest_api.sample_api.root_resource_id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
}

module "sample" {
  source                     = "../mock-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_Mock.id
  endpoint_name              = "sample"
  response                   = jsonencode({ status : "success", count : 123, sort : true })
}
