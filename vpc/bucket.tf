resource "aws_s3_bucket" "remote-state-btenorio" {
  bucket = "remote-state-btenorio"

  tags = {
    Name        = "remote-state-btenorio-name"
  }
}