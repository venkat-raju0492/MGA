output "cf_arn" {
  value = aws_cloudfront_origin_access_identity.cf-origin-identity.s3_canonical_user_id
}

output "cf_id" {
  value = aws_cloudfront_origin_access_identity.cf-origin-identity.id
}