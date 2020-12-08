
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

module "channelByChannelNo" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelByChannelNo"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelByChannelNo"
}

module "channelsCurrentProgram" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelsCurrentProgram"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelsCurrentProgram"
}

module "channelsCurrentProgramSingleChannel" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelsCurrentProgramSingleChannel"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelsCurrentProgramSingleChannel"
}

module "singleChannelByDateRange" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "singleChannelByDateRange"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/singleChannelByDateRange"
}

module "channelsCurrentProgramBySatelliteType" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelsCurrentProgramBySatelliteType"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelsCurrentProgramBySatelliteType"
}

module "broadcastDetail" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "broadcastDetail"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/broadcastDetail"
}

module "search" {
  source                     = "../http-resource-module"
  authorizer_id              = aws_api_gateway_authorizer.MyAuthorizer.id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "search"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/search"
}
