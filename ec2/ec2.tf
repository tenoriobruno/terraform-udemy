#esse recurso n cria a key pair, só sobe na AWS. Para criar a key pair use ssh-keygen -f aws-ec2-key
#esse comando vai criar duas keys: a private key aws-ec2-key e a públic key aws-ec2-key.pub
resource "aws_key_pair" "ec2_pub_key" {
  key_name   = "aws-ec2-key"
  public_key = file("./aws-ec2-key.pub")
}

resource "aws_instance" "ec2_instance" {
  ami                         = "ami-04dd23e62ed049936" #AMI é por região
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ec2_pub_key.key_name
  subnet_id                   = data.terraform_remote_state.remote_data_source_vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.remote_data_source_vpc.outputs.security_group_id]
  associate_public_ip_address = true

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

  provisioner "remote-exec" {
    inline = [
      "echo subnet_id: ${data.terraform_remote_state.remote_data_source_vpc.outputs.subnet_id} >> ./network_info.txt",
      "echo security_group_id: ${data.terraform_remote_state.remote_data_source_vpc.outputs.security_group_id} >> ./network_info.txt"
    ]
  }

  # Copies the teste.txt file to ~/teste_ec2.txt
  provisioner "file" {
    source      = "./teste.txt"
    destination = "˜/teste_ec2.txt"
  }

  # Copies the string in content into ~/ami.txt
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "~/ami.txt"
  }

  tags = {
    Name = "ec2-instance-terraform"
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

