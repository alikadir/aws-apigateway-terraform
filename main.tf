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
