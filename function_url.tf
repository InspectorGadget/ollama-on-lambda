resource "aws_lambda_function_url" "ollama" {
  depends_on = [
    aws_lambda_function.ollama,
    null_resource.post_deployment
  ]

  function_name      = aws_lambda_function.ollama.function_name
  authorization_type = "NONE"
  invoke_mode        = "RESPONSE_STREAM"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}
