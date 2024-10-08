resource "aws_s3_bucket" "remote_state_btenorio" {
  bucket = "remote-state-btenorio"

  tags = {
    Name        = "remote-state-btenorio-name"
  }
}