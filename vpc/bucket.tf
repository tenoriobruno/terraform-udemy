resource "aws_s3_bucket" "remote_state_btenorio" {
  bucket = "remote-state-btenorio"

  tags = {
    Name = "remote-state-btenorio-name"
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.remote_state_btenorio.id
  versioning_configuration {
    status = "Enabled"
  }
}