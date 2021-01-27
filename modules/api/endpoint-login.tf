module "LoginLambda" {
  source               = "../endpoint-lambda"
  function_handler     = "index.handler"
  function_name        = "LoginLambda"
  function_source_path = "./login-lambda-source"
}

module "Parent_Auth" {
  source                     = "../parent-resource-module"
  endpoint_name              = "auth"
  parent_or_root_resource_id = aws_api_gateway_rest_api.sample_api.root_resource_id
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
}

module "login" {
  source                     = "../lambda-resource-module"
  rest_api_id                = aws_api_gateway_rest_api.sample_api.id
  parent_or_root_resource_id = module.Parent_Auth.id
  endpoint_name              = "login"
  function_arn               = module.LoginLambda.invoke_arn

}
