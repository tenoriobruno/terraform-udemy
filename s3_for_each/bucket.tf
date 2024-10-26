resource "aws_s3_bucket" "bucket_for_each" {
  #vai criar 3 buckets iterando na var.map_example
  for_each = var.map_example
    bucket = "remote-state-btenorio-${each.key}"
    tags = {
    Name = "remote-state-btenorio-name-${each.value}"
  }
}