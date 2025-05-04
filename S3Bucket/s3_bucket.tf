/* 
*   Create S3 Bucket
*/
resource "aws_s3_bucket" "source_bucket" {
  bucket = "terraform-bucket-source.test"
}
resource "aws_s3_bucket" "replica_bucket" {
  bucket = "terraform-bucket-replica.test"
}

/* 
*   Versionin enable for s3 buckets
*/
resource "aws_s3_bucket_versioning" "source_versioning" {
  bucket = aws_s3_bucket.source_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_versioning" "replica_versioning" {
  bucket = aws_s3_bucket.replica_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

/* 
*   Upload index and error htmls to the bucket 
*/
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.source_bucket.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  depends_on   = [aws_s3_bucket_replication_configuration.replication]
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.source_bucket.id
  key          = "error.html"
  source       = "${path.module}/error.html"
  content_type = "text/html"
  depends_on   = [aws_s3_bucket_replication_configuration.replication]
}

/* 
*   Other stuff for bucket
*/
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.source_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "source_bucket_access_block" {
  bucket = aws_s3_bucket.source_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.source_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.source_bucket.arn}/*"
      }
    ]
  })
}


