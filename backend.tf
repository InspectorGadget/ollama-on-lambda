terraform {
  backend "s3" {
    bucket = "ollama-on-aws-lambda-state"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}
