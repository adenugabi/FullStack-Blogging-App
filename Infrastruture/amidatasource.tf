data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "redhat" {
    most_recent = true
     owners = ["309956199498"]

  filter {
    name = "name"
    values = ["RHEL-9.3.0_HVM-20240117-x86_64-49-Hourly2-GP3"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu" {
    most_recent = true
     owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240701"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

