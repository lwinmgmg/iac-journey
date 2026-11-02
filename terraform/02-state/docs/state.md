# Terraform State

# State Location [terraform.tfstate]
Terraform store the state in terraform.tfstate file as plain text when a plan is applied.

# Version Lock [terraform.tfstate]
Version lock file create when the terraform is initialize uisng terraform init ... and lock the installed version not to change in the future run.
We need to explictly update the version if we want to update

# Versioning and encryption
State are stored as plain text in terraform state file and it store in plain text even the secrets and api keys. To solve this problem, we can use aws parameter store with versioning.
IF we want to change the generated password and apply, we need to change the version value to be effective.

# Bootstrap Problem Solve
We use Remote backend on S3 to solve this. 
You can check in backend.tf file.
