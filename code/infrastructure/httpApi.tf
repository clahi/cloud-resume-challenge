resource "aws_apigatewayv2_api" "httpApi" {
  name          = "httpApi"
  protocol_type = "HTTP"
  cors_configuration {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
    max_age       = 5
  }
}

resource "aws_apigatewayv2_integration" "lambda-intgration" {
  api_id           = aws_apigatewayv2_api.httpApi.id
  integration_type = "AWS_PROXY"

  connection_type      = "INTERNET"
  description          = "Lambda example"
  integration_method   = "POST"
  integration_uri      = aws_lambda_function.dynamodb-lambda-function.invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "get-route" {
  api_id    = aws_apigatewayv2_api.httpApi.id
  route_key = "GET /"

  target = "integrations/${aws_apigatewayv2_integration.lambda-intgration.id}"
}

resource "aws_apigatewayv2_route" "post-route" {
  api_id    = aws_apigatewayv2_api.httpApi.id
  route_key = "POST /"

  target = "integrations/${aws_apigatewayv2_integration.lambda-intgration.id}"
}

resource "aws_apigatewayv2_route" "options-route" {
  api_id    = aws_apigatewayv2_api.httpApi.id
  route_key = "OPTIONS /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda-intgration.id}"
}

resource "aws_apigatewayv2_stage" "example" {
  api_id      = aws_apigatewayv2_api.httpApi.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamodb-lambda-function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.httpApi.execution_arn}/*"
}

output "api_endpoint" {
  value = aws_apigatewayv2_api.httpApi.api_endpoint
}