# Cloud Static

- Use Terraform Cloud, Github (+Actions), and AWS to quickly create an inexpensive, low-maintenance static website.
- Update your site with a painless release workflow.

Ship an update to your static site in two easy steps:

1. push a branch with your content/ changes
1. merge your PR


# setup

## accounts required

- github.com (free)
- terraform cloud (free)
- aws (free tier eligible)

## repo setup

- clone this repo
- `rm -rf .git`
- `git init`
- github.com
  - create a new empty repo
- `git remote add origin <remote-url>`

## configuration

- AWS
  - *out of band*, create an AWS user `terraform-cloud` and access key, with attached managed policies:
    - IAMFullAccess
    - AmazonS3FullAccess

- Terraform Cloud
  - create an organization
  - create a workspace in the organization
  - Add environment variables to your workspace, for the `terraform-cloud` access keys you created above:
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
  - update the terraform cloud remote backend details in `main.tf`

- After the first `terraform apply`:
  - create github repo secrets (settings > secrets), using the values in terraform cloud (view in state):
    - created for the `<project-name>_CI` user
      - `AWS_ACCESS_KEY_ID`
      - `AWS_SECRET_ACCESS_KEY`
    - `bucket_name`
