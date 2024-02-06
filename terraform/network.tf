resource "aws_db_subnet_group" "craft_beer_subnet_group" {
  name       = "craft-beer-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "Craft Beer Subnet Group"
  }
}


resource "aws_vpc" "craft_beer_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Craft Beer VPC"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.craft_beer_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.craft_beer_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
}

resource "aws_security_group" "craft_beer_rds_sg" {
  name_prefix = "craft-beer-rds-"

  vpc_id = aws_vpc.craft_beer_vpc.id
  ingress {
    from_port   = local.db_port
    to_port     = local.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
