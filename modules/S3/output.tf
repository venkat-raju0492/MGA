output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_id" {
  description = "The bucket id"
  value       = aws_s3_bucket.s3_bucket.id
}