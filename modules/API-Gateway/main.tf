resource "aws_api_gateway_rest_api" "api-gateway" {
  name = "${var.project}-api-gateway-${var.environment}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = merge(var.common_tags, map(
    "Name", "${var.project}-api-gateway-${var.environment}"
  ))
}