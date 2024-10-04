
provider "aws" {
  region = "eu-west-2"
}

# module "vpc" {
#   source      = "terraform-aws-modules/vpc/aws"
  

# }

resource "aws_instance" "master" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["testing"]
  subnet_id     = var.public_subnets[0]
  key_name = "project"
  security_groups = [
    aws_security_group.sg.id
  ]

#   user_data = file("${path.module}/kubeadm_master_userdata.sh")

  tags = {
    Name = "Master"
  }
}

resource "aws_instance" "slave1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["testing"]
  subnet_id     = var.public_subnets[0]
#   key_name = "project"
  security_groups = [
    aws_security_group.sg.id
  ]

  tags = {
    Name = "slave-1"
  }
}

resource "aws_instance"  "slave2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["testing"]
  subnet_id     = var.public_subnets[0]
  key_name = "project"
  security_groups = [
    aws_security_group.sg.id
  ]

  tags = {
    Name = "slave-2"
  }
}

resource "aws_instance" "sonarqube" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["prod"]
  subnet_id     = var.public_subnets[0]
  key_name = "project"
  security_groups = [
    aws_security_group.sg.id
  ]


  tags = {
    Name = "Sonarqube"
  }
}

resource "aws_instance" "nexus" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["prod"]
  subnet_id     = var.public_subnets[0]
  key_name = "project"
  security_groups = [
    aws_security_group.sg.id
  ]


  tags = {
    Name = "nexus"
  }
}

resource "aws_instance" "Jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["prod"]
  subnet_id     = var.public_subnets[0]
  key_name = "project"
  security_groups = [
    aws_security_group.sg.id
  ]


  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "Monitor" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["testing"]
  subnet_id     = var.public_subnets[0]
  key_name = "project"
  security_groups = [
    aws_security_group.sg.id
  ]


  tags = {
    Name = "Monitoring"
  }
}

resource "aws_security_group" "sg" {
  name        = "project-security-group"
  description = "Security group with multiple inbound rules"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SMTP from anywhere"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow custom TCP ports 3000-10000 from anywhere"
    from_port   = 3000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow custom TCP port 6443 from anywhere"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow custom TCP ports 30000-32767 from anywhere"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SMTPS from anywhere"
    from_port   = 465
    to_port     = 465
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
    Name = "project"
  }
}

