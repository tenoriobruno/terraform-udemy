output "bucket_id_1" {
  description = "ID da bucket criada com Terraform"
  value       = aws_s3_bucket.bucket_for_each["key1"].id
}

output "bucket_arn_1" {
  description = "Nome da bucket criada com Terraform"
  value       = aws_s3_bucket.bucket_for_each["key1"].arn
}

output "bucket_id_2" {
  description = "ID da bucket criada com Terraform"
  value       = aws_s3_bucket.bucket_for_each["key1"].id
}

output "bucket_arn_2" {
  description = "Nome da bucket criada com Terraform"
  value       = aws_s3_bucket.bucket_for_each["key1"].arn
}

output "bucket_id_3" {
  description = "ID da bucket criada com Terraform"
  value       = aws_s3_bucket.bucket_for_each["key3"].id
}

output "bucket_arn_3" {
  description = "Nome da bucket criada com Terraform"
  value       = aws_s3_bucket.bucket_for_each["key3"].arn
}

