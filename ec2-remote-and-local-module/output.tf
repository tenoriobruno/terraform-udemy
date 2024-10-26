#output para sabe qual é o IP da instância para fazer ssh
output "ec2_instance_pub_ip" {
  description = "IP da instância EC2"
  value       = aws_instance.ec2_instance.public_ip
}