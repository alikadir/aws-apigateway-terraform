module "Authenticator_Lambda" {
    source  = "./modules/lambda"
    function_name = var.function_name
    role_arn = var.role_arn
    function_handler = var.function_handler
}
