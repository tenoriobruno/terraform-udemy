#esse recurso n cria a key pair, só sobe na AWS. Para criar a key pair use ssh-keygen -f aws-ec2-key
#esse comando vai criar duas keys: a private key aws-ec2-key e a públic key aws-ec2-key.pub
resource "aws_key_pair" "ec2_pub_key" {
  key_name   = "aws-ec2-key-${var.env}"
  public_key = file("./aws-ec2-key.pub")
}

resource "aws_instance" "ec2_instance" {
  ami                         = "ami-0866a3c8686eaeeba" #AMI é por região
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ec2_pub_key.key_name
  #usando o módulo remoto (no github) para atribuir os seus outputs na ec2
  subnet_id                   = module.vpc-remote.subnet_id
  vpc_security_group_ids      = [module.vpc-remote.security_group_id]
  #usando o módulo local para atribuir os seus outputs na ec2
  #subnet_id                   = module.vpc-remote.subnet_id
  #vpc_security_group_ids      = [module.vpc-remote.security_group_id]
  associate_public_ip_address = true
  user_data                   = file("./update_ubuntu.sh")

  #use provisioner só em último caso. Use user_data para enviar arquivos para a ec2
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    password = file("./aws-ec2-key")
    host     = self.public_ip
  }

  /*
  provisioner "remote-exec" {
    inline = [
      "echo subnet_id: ${data.terraform_remote_state.remote_data_source_vpc.outputs.subnet_id} >> ./network_info.txt",
      "echo security_group_id: ${data.terraform_remote_state.remote_data_source_vpc.outputs.security_group_id} >> ./network_info.txt"
    ]
  }
 Error: remote-exec provisioner error
│ 
│   with aws_instance.ec2_instance,
│   on ec2.tf line 29, in resource "aws_instance" "ec2_instance":
│   29:   provisioner "remote-exec" {
│ 
│ timeout - last error: SSH authentication failed (ubuntu@3.87.221.35:22): ssh: handshake failed: ssh: unable to authenticate, attempted methods [none publickey], no supported methods remain
*/
  /*
  # Copies the teste.txt file to ~/teste_ec2.txt
  provisioner "file" {
    source      = "./teste.txt"
    destination = "~/teste_ec2.txt"
  }

  # Copies the string in content into ~/ami.txt
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "~/ami.txt"
  }
│ Error: file provisioner error
│ 
│   with aws_instance.ec2_instance,
│   on ec2.tf line 45, in resource "aws_instance" "ec2_instance":
│   45:   provisioner "file" {
│ 
│ timeout - last error: SSH authentication failed (ubuntu@98.82.16.175:22): ssh: handshake failed: ssh: unable to authenticate, attempted methods [none publickey], no supported methods remain
  */

  tags = {
    Name = "ec2-instance-terraform-${var.env}"
  }
}
#após criar o bucket mimitesteb manualmente no console,
#defina ele e importe
#terraform import aws_s3_bucket.test_bucket mimitesteb
/*resource "aws_s3_bucket" "test_bucket" {
  bucket = "mimitesteb"

  tags = {
    Name = "mimitestb-terraform"
  }
}*/

