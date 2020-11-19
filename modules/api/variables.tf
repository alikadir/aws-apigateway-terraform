variable "agw_restapi_name" {
  type = string
}
variable "endpoint_configuration_types" {
  type = list(string)
}
variable "authorizer_lambda_invoke_arn" {
  type = string
}