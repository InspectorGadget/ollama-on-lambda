# ECR Repository
resource "aws_ecr_repository" "ecr" {
  name         = "${var.project_name}-runtime"
}

# Build Image
resource "null_resource" "build" {
  depends_on = [
    aws_ecr_repository.ecr
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
      # Login to ECR (AWS STS AssumeRole)
      aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com

      # Build Image
      docker build -t ${aws_ecr_repository.ecr.repository_url}:latest . -f Dockerfile --platform linux/arm64 --provenance=false

      # Push Image
      docker push ${aws_ecr_repository.ecr.repository_url}:latest
    COMMAND
  }
}
