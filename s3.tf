# Create S3 Bucket
resource "aws_s3_bucket" "project_1" {
  bucket        = "project-test-dev"
  force_destroy = true
  tags = {
    Name = "${var.env}-S3Bucket"
  }
}
