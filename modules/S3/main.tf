resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project}-${var.s3_bucket}-${var.environment}"
  acl    = var.s3_acl_bucket

  versioning {
    enabled = true
  }

  lifecycle_rule {
    prefix  = "config/"
    enabled = true

    expiration {
      days = var.expiration_days
    }
  }


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.s3_sse_algorithm
      }
    }
  }

  tags = merge(var.common_tags, map(
    "Name", "${var.project}-${var.s3_bucket}-${var.environment}"
  ))
}