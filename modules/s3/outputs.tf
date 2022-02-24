output "bucket_name" {
  value       = aws_s3_bucket.demo_tf_bucket.bucket
  description = "Name of the bucket name + prefix"
}
