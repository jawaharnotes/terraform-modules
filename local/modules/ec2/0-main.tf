resource "aws_instance" "myec2" {
  ami                    = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2 (ap-south-1)
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.env}-ec2"
  }
}
