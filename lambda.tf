# Create AWS Lambda Function from ECR Image
resource "aws_lambda_function" "ollama" {
  depends_on = [
    aws_ecr_repository.ecr,
    null_resource.build,
    aws_iam_role.lambda
  ]

  function_name = var.project_name
  architectures = [
    "arm64",
  ]
  package_type = "Image"
  image_uri    = "${aws_ecr_repository.ecr.repository_url}:latest"
  role         = aws_iam_role.lambda.arn
  memory_size  = 8192
  timeout      = 600

  environment {
    variables = {
      RUST_LOG            = "debug"
      PORT                = "8080"
      HOME                = "/mnt/ollama"
      AWS_LWA_INVOKE_MODE = "response_stream"
    }
  }
}

# Update Lambda Image to latest with Lambda API
resource "null_resource" "post_deployment" {
  depends_on = [
    aws_lambda_function.ollama,
    null_resource.build
  ]

  triggers = {
    build_number = timestamp()
  }

  provisioner "local-exec" {
    interpreter = [
      "/bin/sh",
      "-c"
    ]

    command = <<-COMMAND
        # Update Lambda Image to latest with Lambda API
        aws lambda update-function-code --function-name ${aws_lambda_function.ollama.function_name} --image-uri ${aws_ecr_repository.ecr.repository_url}:latest
    COMMAND
  }
}
