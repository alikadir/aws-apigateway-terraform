module "Authenticator_Lambda" {
  source           = "./modules/auth-lambda"
  function_name    = "AuthenticatorFunction"
  function_handler = "index.handler"
}

module "API" {
  source                       = "./modules/api"
  agw_restapi_name             = var.agw_restapi_name
  endpoint_configuration_types = var.endpoint_configuration_types
  authorizer_lambda_invoke_arn = module.Authenticator_Lambda.invoke_arn
  authorizer_lambda_arn        = module.Authenticator_Lambda.arn
}
