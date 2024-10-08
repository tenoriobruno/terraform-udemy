output "bucket_id" {
    description = "ID da bucket criada com Terraform"
    value = aws_s3_bucket.remote_state_btenorio.id
}

output "bucket_name" {
    description = "Nome da bucket criada com Terraform"
    value = aws_s3_bucket.remote_state_btenorio.bucket_name
}
