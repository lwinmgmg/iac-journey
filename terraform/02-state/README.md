# How to run

## Initialize the project with Remote Backend on S3
../state.s3.tfbackend
bucket       = "iac-journey-tfstate-436908790874"
region       = "ap-southeast-1"
encrypt      = true
use_lockfile = true

!note: iac-journey-tfstate-436908790874 must be existed

```bash
terraform init -backend-config=../state.s3.tfbackend
```

## Create the terraform plan
```bash
terraform plan -out=tfplan
```

## Apply the plan
```bash
terraform apply tfplan
# then type yes and enter
```

## How to destroy
```bash
terraform destroy
# then type yes and enter
```
