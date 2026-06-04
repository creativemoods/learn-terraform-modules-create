output "arn" {
  description = "ARN of the bucket."
  value       = aws_s3_bucket.this.arn
}

output "name" {
  description = "Name of the bucket."
  value       = aws_s3_bucket.this.id
}

output "website_domain" {
  description = "Website domain of the bucket."
  value       = aws_s3_bucket_website_configuration.this.website_domain
}

output "website_endpoint" {
  description = "Website endpoint of the bucket."
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}

output "website_url" {
  description = "HTTP URL of the static website."
  value       = "http://${aws_s3_bucket_website_configuration.this.website_endpoint}"
}
