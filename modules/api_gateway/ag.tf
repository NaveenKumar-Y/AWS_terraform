resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "my-http-api"
  protocol_type = "HTTP"
}


resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  api_id = aws_apigatewayv2_api.api_gateway.id
  name   = "my-http-api-stage"
}


resource "aws_apigatewayv2_integration" "api_gateway_integration" {
  api_id           = aws_apigatewayv2_api.api_gateway.id
  integration_type = "AWS_PROXY"

#   connection_type           = "INTERNET"
#   content_handling_strategy = "CONVERT_TO_TEXT"
#   description               = "Lambda example"
#   integration_method        = "POST"
#   integration_uri           = aws_lambda_function.example.invoke_arn
#   passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "aws_api_gateway_route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "$default"
  target = "integrations/${aws_apigatewayv2_integration.api_gateway_integration.id}"
}

