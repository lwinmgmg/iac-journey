# 01 Basic
This project will create AWS bucket. You can change the environment and project name using variable.
AWS bucket will be created according to the environment and project name. AWS bucket name must be unique and so
we add suffix at the end of the bucket name. So the final bucket name will be ```<project>-<environment>-<suffix>```

## How to run
Run the following command create resource required in the project.
```SHELL
terraform plan -out=tfplan
terraform apply tfplan
```

## Destroy the project
Run the following command to destroy the project completely.
```SHELL
terraform destroy
```
