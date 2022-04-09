terraform {
  required_version = "= 0.12.19"

  backend "remote" {
    hostname = "app.terraform.io"
    organization = "<my-org>"
    workspaces {
      name = "<my-workspace>"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "apex_domain" {}

resource "aws_s3_bucket" "apex" {
  bucket        = var.apex_domain
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

data "aws_iam_policy_document" "apex" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.apex_domain}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "apex" {
  bucket = aws_s3_bucket.apex.id
  policy = data.aws_iam_policy_document.apex.json
}

resource "aws_s3_bucket" "www" {
  bucket        = "www.${var.apex_domain}"
  acl           = "public-read"
  force_destroy = true

  website {
    redirect_all_requests_to = aws_s3_bucket.apex.id
  }
}

data "aws_iam_policy_document" "www" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::www.${var.apex_domain}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "www" {
  bucket = aws_s3_bucket.www.id
  policy = data.aws_iam_policy_document.www.json
}

resource "aws_s3_bucket" "preview" {
  bucket        = "${var.apex_domain}-preview"
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  lifecycle_rule {
    id      = "/"
    prefix  = ""
    enabled = true

    expiration {
      days = 7
    }
  }
}

data "aws_iam_policy_document" "preview" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.apex_domain}-preview/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "preview" {
  bucket = aws_s3_bucket.preview.id
  policy = data.aws_iam_policy_document.preview.json
}

resource "aws_s3_bucket" "ops" {
  bucket        = "ops.${var.apex_domain}"
  force_destroy = true
  acl           = "public-read"

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

data "aws_iam_policy_document" "ops" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::ops.${var.apex_domain}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "ops" {
  bucket = aws_s3_bucket.ops.id
  policy = data.aws_iam_policy_document.ops.json
}

resource "aws_s3_bucket" "data_private" {
  bucket        = "${var.apex_domain}-data-private"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "aws_iam_access_key" "ci" {
  user = aws_iam_user.ci.name
}

resource "aws_iam_user" "ci" {
  name = "${var.apex_domain}-ci"
  path = "/"
}

data "aws_iam_policy_document" "ci" {
  statement {
    actions   = [
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.apex.arn}/*"]
  }

  statement {
    actions   = [
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.preview.arn}/*"]
  }

  statement {
    actions   = [
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]
    effect  = "Allow"

    resources = [
      "${aws_s3_bucket.data_private.arn}/*",
    ]
  }
}

resource "aws_iam_user_policy" "ci" {
  name   = "${var.apex_domain}-ci"
  user   = aws_iam_user.ci.name
  policy = data.aws_iam_policy_document.ci.json
}

resource "aws_iam_access_key" "ops_ci" {
  user = aws_iam_user.ops_ci.name
}

resource "aws_iam_user" "ops_ci" {
  name = "${var.apex_domain}-ops-ci"
  path = "/"
}

data "aws_iam_policy_document" "ops_ci" {
  statement {
    actions   = [
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]
    effect  = "Allow"

    resources = [
      "${aws_s3_bucket.ops.arn}/*",
    ]
  }

  statement {
    actions   = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket"
    ]
    effect  = "Allow"

    resources = [
      "${aws_s3_bucket.data_private.arn}/*",
    ]
  }
}

resource "aws_iam_user_policy" "ops_ci" {
  name   = "${var.apex_domain}_ops_ci"
  user   = aws_iam_user.ops_ci.name
  policy = data.aws_iam_policy_document.ops_ci.json
}
