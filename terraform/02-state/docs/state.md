# How state works for 02-state

## Where the state lives
The state is not on my laptop. It is stored in S3:

- Bucket: `iac-journey-tfstate-436908790874` (region `ap-southeast-1`)
- Key: `02-state/terraform.tfstate`

`backend.tf` only has the `key`. The bucket, region, `encrypt` and `use_lockfile`
come from `../state.s3.tfbackend`, which I pass with
`terraform init -backend-config=../state.s3.tfbackend`.
That way every config shares one backend file and only the key is different.

## State locking
`use_lockfile = true` turns on locking. When `plan` or `apply` starts, Terraform
writes a file next to the state: `02-state/terraform.tfstate.tflock`.
If a second run starts while that file exists, it fails with
"Error acquiring the state lock" (S3 returns 412 PreconditionFailed) and shows
the lock ID, who holds it and when it was created.
When the first run finishes, the `.tflock` file is deleted.
This stops two people from writing the state at the same time and corrupting it.

## Why the state bucket is versioned and encrypted
- **Versioning:** every apply writes a new version of `terraform.tfstate`.
  If the state gets broken or deleted, I can restore an older version.
  Old versions are deleted after 30 days by the lifecycle rule.
- **Encryption:** state stores every attribute in plain text, including
  sensitive values like passwords. The bucket uses SSE (AES256) and the backend
  has `encrypt = true`.
- **Other protection:** public access is fully blocked, a bucket policy denies
  requests that are not HTTPS, and `prevent_destroy` stops Terraform from
  deleting the bucket by mistake.

## Bootstrap (chicken and egg)
The state bucket must exist before any config can use the S3 backend,
but the bucket itself is created by Terraform. So the bootstrap config:

1. Was first applied with **local** state (no backend block).
2. Then I added the S3 backend and ran `terraform init -migrate-state`,
   which copied the local state into the bucket.
3. After checking it in S3, I deleted the local `terraform.tfstate`.

## Stuck lock
If a run crashed (Ctrl+C, laptop sleep, network cut), the `.tflock` file can stay
behind and every run fails with "Error acquiring the state lock".

1. Read the error: check `Who` and `Created`. Make sure nobody (and no other
   terminal of mine) is still running Terraform, e.g. `ps aux | grep terraform`.
2. Only if nothing is running: `terraform force-unlock <LOCK_ID>`
   (the ID is in the error message).
3. Never force-unlock while another run is really working.