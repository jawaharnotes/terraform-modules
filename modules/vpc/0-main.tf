resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count      = length(var.private_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index]
  tags = {
    Name = "${var.env}-private-${count.index}"
  }
}

resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id
  name   = "${var.env}-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #cidr_blocks = ["0.0.0.0/0"] → allows traffic from anywhere in the world (not secure in production, but common for testing).
  }

  egress {
    from_port   = 0     #from_port = 0, to_port = 0 with protocol = "-1" → means all protocols, all ports.
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]   #Instances can reach the internet (HTTP, HTTPS, updates, etc.).
  }
}
