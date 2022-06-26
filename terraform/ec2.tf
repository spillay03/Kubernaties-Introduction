data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

# Get VPC id of default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_iam_instance_profile" "lab_profile" {
    name = "LabInstanceProfile"
}
resource "aws_default_subnet" "default" {
  availability_zone = "us-east-1a"
  tags = {
    Name = "Default subnet for us-east-1"
  }
}

# Create Amazon Linux EC2 instances in a default VPC
resource "aws_instance" "linux_vm" {
  ami                    = data.aws_ami.amazon_linux_2.id
  key_name               = aws_key_pair.web_key.key_name
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.aws_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.lab_profile.name
  user_data              = file("docker.sh")
  tags = {
    Name = "LinuxServer-EC2"
  }
}

resource "aws_security_group" "aws_sg" {
  name        = "ec2_sg"
  description = "Allow http inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Http"
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Http"
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = "week5"
  public_key = file("week5.pub")
}

resource "aws_ecr_repository" "aws_repo" {
  name                 = "clo835-assignment2"
  image_tag_mutability = "MUTABLE"
}