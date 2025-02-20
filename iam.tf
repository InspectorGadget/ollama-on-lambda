resource "aws_iam_role" "lambda" {
  name               = "${var.project_name}-role"
  assume_role_policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": [
                      "lambda.amazonaws.com",
                      "apigateway.amazonaws.com",
                      "events.amazonaws.com"
                    ]
                },
                "Effect": "Allow",
                "Sid": ""
            }
        ]
    }
    EOF
}

# Attach Basic Execution Policy to Lambda Role
resource "aws_iam_role_policy_attachment" "lambda" {
  depends_on = [
    aws_iam_role.lambda
  ]

  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Attach AWSLambdaVPCAccessExecutionRole
resource "aws_iam_role_policy_attachment" "vpc" {
  depends_on = [
    aws_iam_role.lambda
  ]

  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}