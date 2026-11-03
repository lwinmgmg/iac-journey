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

Only add a bucket and its versioning for logs bucket with the name "logs". Leave without creating for the other buckets.
## Create the terraform plan
```bash
terraform plan -out=tfplan
```
It will plan to create logs related bucket only

## Apply the plan
```bash
terraform apply plan
```


## Then add a file moved
Add the following in the moved.tf to move logs into this["logs"]
```terraform
moved {
    from = aws_s3_bucket.logs
    to = aws_s3_bucket.this["logs"]
}

moved {
    from = aws_s3_bucket_versioning.logs
    to = aws_s3_bucket_versioning.this["logs"]
}

moved {
    from = aws_s3_bucket_public_access_block.logs
    to = aws_s3_bucket_public_access_block.this["logs"]
}
```

## Then add a import file to import existing bucket into lagency
Add the following line in the import.tf.
```terraform
import {
  to = aws_s3_bucket.this["legacy"]
  id = var.buckets["legacy"].name
}
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
# Check and verify the resources that will be destroyed.
# then type yes and enter
```
