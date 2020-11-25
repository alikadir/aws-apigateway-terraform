module "Authenticator_Lambda" {
  source           = "./modules/lambda"
  function_name    = var.function_name
  role_arn         = var.role_arn
  function_handler = var.function_handler
}

module "API" {
  source                       = "./modules/api"
  agw_restapi_name             = var.agw_restapi_name
  endpoint_configuration_types = var.endpoint_configuration_types
  authorizer_lambda_invoke_arn = module.Authenticator_Lambda.invoke_arn
}

module "http-module" {
  source           = "./modules/http-module"
  authorizer_id    = module.API.authorizer_id
  rest_api_id      = module.API.rest_api_id
  root_resource_id = module.API.root_resource_id
  endpoint_name    = "themes"
  endpoint_url     = "http://api-worker-tvguide.digiturk.com.tr/api/themes"
}
