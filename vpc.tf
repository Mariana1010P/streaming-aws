resource "aws_vpc" "main"{
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public"{
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-2b"  # Segunda zona de disponibilidad
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private"{
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
}

resource "aws_security_group" "sg"{
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
