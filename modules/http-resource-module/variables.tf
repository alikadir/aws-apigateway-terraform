variable "parent_or_root_resource_id" {
  type = string
}
variable "rest_api_id" {
  type = string
}
variable "authorizer_id" {
  type = string
}
variable "endpoint_name" {
  type = string
}
variable "endpoint_url" {
  type = string
}
variable "use_proxy_parameter" {
  type    = bool
  default = false
}
