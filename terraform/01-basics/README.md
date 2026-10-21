# 01 Basic
This project will create AWS bucket. You can change the environment and project name using variable.
AWS bucket will be created according to the environment and project name. AWS bucket name must be unique and so
we add suffix at the end of the bucket name. So the final bucket name will be ```<project>-<environment>-<suffix>```

## How to run
Run the following command create resource required in the project.
```SHELL
# Login to aws profile
aws sso login --profile learn
export AWS_PROFILE=learn
aws sts get-caller-identity

# Initialize the terraform plugins
terraform init

# Create the plan
terraform plan -out=tfplan # Plan: 4 to add, 0 to change, 0 to destroy.
# 1. random_string, aws_s3_bucket, aws_s3_bucket_versioning, aws_s3_bucket_public_access_block

# Apply the plan
terraform apply tfplan # It will output bucket name and bucket arn
```

## Destroy the project
Run the following command to destroy the project completely.
```SHELL
terraform destroy # Plan: 0 to add, 0 to change, 4 to destroy.
```
