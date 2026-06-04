# Creates the bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = var.tags
}

# Enables static website hosting
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

# Makes the bucket owner automatically own all objects and disables ACLs.
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Allows public bucket policies
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

# Allows everyone to read objects
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  depends_on = [
    aws_s3_bucket_public_access_block.this
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadObjects"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}
[ ubuntu@studentx:~/learn-terraform-modules-create ] (main) $ cat modules/aws-s3-static-website-bucket/variables.tf 
variable "bucket_name" {
  description = "Name of the S3 bucket. Must be globally unique."
  type        = string
}

variable "index_document" {
  description = "Index document for the static website."
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Error document for the static website."
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
