variable "function_name" {
  type = string
}
variable "role_arn" {
  type = string
}
variable "function_handler" {
  type = string
}
variable "agw_restapi_name" {
  type = string
}
variable "endpoint_configuration_types" {
  type = list(string)
}