# Ollama on AWS Lambda

# Technologies
1. Terraform
2. AWS Lambda
3. Docker
4. Bash Scripting

# Description
This project exerts the simple way on running Ollama on AWS Lambda. This leverages the power of serverless computing to run Ollama on AWS Lambda while staying relevant to the AWS Free Tier. This project is a simple demonstration of how to run Ollama on AWS Lambda.

Please do not use this method for Production use-case as the inteferencing is still slow on AWS Lambda. But this is a great way of running Ollama on AWS Lambda for testing purposes or learning purposes. 

# Setting up the environment
1. `git clone https://github.com/InspectorGadget/ollama-on-lambda.git`
2. Update `backend.tf` with your S3 Bucket name.
3. Run `terraform init`
4. Verify the changes that would be performed on your environment.
5. Run `terraform apply`
6. Wait for the changes to be applied.
7. Perform inferencing with your newly deployed Ollama instance.