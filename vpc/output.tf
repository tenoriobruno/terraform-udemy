output "bucket_id" {
  description = "ID da bucket criada com Terraform"
  value       = aws_s3_bucket.remote_state_btenorio.id
}

output "bucket_arn" {
  description = "Nome da bucket criada com Terraform"
  value       = aws_s3_bucket.remote_state_btenorio.arn
}

output "subnet_id"{
  description = "ID da subnet"
  value = aws_subnet.subnet.id
}

output "security_group_id"{
  description = "ID da securty group"
  value = aws_security_group.security_group.id
}