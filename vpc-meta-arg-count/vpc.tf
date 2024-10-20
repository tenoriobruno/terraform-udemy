resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_subnet" "subnet" {
  count             = 4
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = "us-east-1a" # por default estava a 2d. Estava dando no apply do ec2, pois a 2d n estava disponível

  tags = {
    Name = "subnet-terraform-${count.index}"
  }
}
