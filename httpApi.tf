resource "aws_apigatewayv2_api" "httpApi" {
  name          = "httpApi"
  protocol_type = "HTTP"
  cors_configuration {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["GET"]
    allow_origins = ["*"]
    max_age       = 3600
  }
  target = aws_lambda_function.dynamodb-lambda-function.arn
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