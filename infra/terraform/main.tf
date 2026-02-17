# resource "aws_iam_role" "lambda_role" {
#   name = "cloud_pos_lambda_role"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
 role = "cloud_pos_lambda_role"
 }

resource "aws_lambda_function" "api" {
  function_name = "cloud-pos-api"

  filename      = "../../backend/api/dist.zip"
  source_code_hash = filebase64sha256("../../backend/api/dist.zip")

  handler       = "lambda.handler"
  runtime       = "nodejs18.x"

  role =  "arn:aws:iam::687337999212:role/cloud_pos_lambda_role"
}

resource "aws_apigatewayv2_api" "http_api" {
  name          = "cloud-pos-api-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.api.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"
}
output "api_url" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}

