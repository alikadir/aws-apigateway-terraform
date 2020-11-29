module "Authenticator_Lambda" {
  source           = "./modules/lambda"
  function_name    = var.function_name
  function_handler = var.function_handler
}

module "API" {
  source                       = "./modules/api"
  agw_restapi_name             = var.agw_restapi_name
  endpoint_configuration_types = var.endpoint_configuration_types
  authorizer_lambda_invoke_arn = module.Authenticator_Lambda.invoke_arn
  authorizer_lambda_arn        = module.Authenticator_Lambda.arn
}

module "Parent_TvGuide" {
  source                     = "./modules/parent-resource-module"
  endpoint_name              = "tv-guide"
  parent_or_root_resource_id = module.API.root_resource_id
  rest_api_id                = module.API.rest_api_id
}

module "themes" {
  source                     = "./modules/http-resource-module"
  authorizer_id              = module.API.authorizer_id
  rest_api_id                = module.API.rest_api_id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "themes"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/themes"

}

module "channels" {
  source                     = "./modules/http-resource-module"
  authorizer_id              = module.API.authorizer_id
  rest_api_id                = module.API.rest_api_id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channels"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channels"
}

module "channelsCurrentProgram" {
  source                     = "./modules/http-resource-module"
  authorizer_id              = module.API.authorizer_id
  rest_api_id                = module.API.rest_api_id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelsCurrentProgram"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelsCurrentProgram"
}

module "channelByChannelNo" {
  source                     = "./modules/http-resource-module"
  authorizer_id              = module.API.authorizer_id
  rest_api_id                = module.API.rest_api_id
  parent_or_root_resource_id = module.Parent_TvGuide.id
  endpoint_name              = "channelByChannelNo"
  endpoint_url               = "http://api-worker-tvguide.digiturk.com.tr/api/channelByChannelNo"
}

module "mockSample" {
  source                     = "./modules/mock-resource-module"
  authorizer_id              = module.API.authorizer_id
  rest_api_id                = module.API.rest_api_id
  parent_or_root_resource_id = module.API.root_resource_id
  endpoint_name              = "mock-sample"
  response                   = jsonencode({ status : "success", count : 123, sort : true })
}
