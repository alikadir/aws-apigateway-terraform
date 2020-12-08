output "authorizer_id" {
  value = aws_api_gateway_authorizer.MyAuthorizer.id
}
output "rest_api_id" {
  value = aws_api_gateway_rest_api.sample_api.id
}
output "root_resource_id" {
  value = aws_api_gateway_rest_api.sample_api.root_resource_id
}
