# Current account
data "aws_caller_identity" "current" {}

# Current region
data "aws_region" "current" {}

# Get VPC by ID
data "aws_vpc" "main" {
  id = var.vpc_id
}

# Get Private Subnets
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["*Private*"]
  }
}

# Get Public Subnets
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["*Public*"]
  }
}

