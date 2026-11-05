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

## Reading the plan

Last plan:

```
Plan: 1 to import, 8 to add, 1 to change, 0 to destroy.
```

- **0 to destroy:** I check this first. Nothing is deleted, so the refactor is safe.
  If this number were not 0, I would stop and read why before applying.
- **1 to import:** `aws_s3_bucket.this["legacy"]` was imported. The bucket
  `myproject-handmade-htet` already existed (made by hand in Lab 4); the
  `import` block added it to state instead of creating a new one.
- **1 to change:** the same `legacy` bucket is updated in place, because
  `default_tags` adds my tags that the hand-made bucket did not have.
  Only tags change, the bucket is not recreated.
- **8 to add:**
  - `random_string.suffix` (1)
  - `aws_s3_bucket.this["logs"]` and `["artifacts"]` (2)
  - `aws_s3_bucket_versioning.this["logs"]` and `["artifacts"]` (2),
    none for `legacy` because its `versioning = false`
  - `aws_s3_bucket_public_access_block.this` for logs, artifacts, legacy (3)
- **moved blocks:** if the old `aws_s3_bucket.logs` is already in state, the plan
  shows `# aws_s3_bucket.logs has moved to aws_s3_bucket.this["logs"]` and does not
  destroy/recreate it. On a fresh state there is nothing to move, so they do nothing.

