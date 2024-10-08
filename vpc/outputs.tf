output "bucket_id" {
  description = "ID da bucket criada com Terraform"
  value       = aws_s3_bucket.remote_state_btenorio.id
}

output "bucket_arn" {
  description = "Nome da bucket criada com Terraform"
  value       = aws_s3_bucket.remote_state_btenorio.arn
}
