resource "aws_api_gateway_rest_api" "sample_api" {
  name = var.agw_restapi_name
  endpoint_configuration {
    types = var.endpoint_configuration_types
  }
}


module "Parent_TvGuide" {
  source                     = "../parent-resource-module"
  endpoint_name              = "tv-guide"
  parent_or_root_resource_id = aws_api_gateway_rest_api.sample_api.root_resource_id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
}

module "themes" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "themes"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/themes"

}

module "channels" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channels"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channels"
}

module "channelsCurrentProgram" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelsCurrentProgram"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelsCurrentProgram"
}

module "channelByChannelNo" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelByChannelNo"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelByChannelNo"
}

module "mockSample" {
  source                     = "../mock-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = aws_api_gateway_rest_api.sample_api.root_resource_id
  endpoint_name              = "mock-sample"
  response                   = jsonencode({ status : "success", count : 123, sort : true })
}
