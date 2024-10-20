resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"# por default estava a 2d. Estava dando no apply do ec2, pois a 2d n estava disponível

  tags = {
    Name = "subnet-terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-terraform"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    #o igw tem que estar aberto para a internet toda
    #para que a ec2 que estiver nessa subnet acesse a internet
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route-table-terraform"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "security_group" {
  name        = "security-group-terraform"
  description = "Permitir acesso a porta 22 para ssh"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "security-group-terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sg_ingress" {
  description       = "ssh porta 22"
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    Name = "sg-ingress-terraform"
  }
}


resource "aws_vpc_security_group_egress_rule" "securty_group" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags = {
    Name = "sg-egress-terraform"
  }
}