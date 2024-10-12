#esse recurso n cria a key pair, só sobe na AWS. Para criar a key pair use ssh-keygen -f aws-ec2-key
#esse comando vai criar duas keys: a private key aws-ec2-key e a públic key aws-ec2-key.pub
resource "aws_key_pair" "deployer" {
  key_name   = "aws-ec2-key"
  public_key = file("./aws-ec2-key.pub")
}