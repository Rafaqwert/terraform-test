terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-iac-aula2" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-iac-aula2"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp3"
  }

  security_groups = [aws_security_group.sg_aula_iac.name, "default"]

  key_name = "key-aula-iac"

  # vpc_security_group_ids = "subnet-050a5c48e052e5f4a"

  subnet_id = aws_subnet.minha_subrede.id
}

variable "porta_http" {
  description = "porta http"
  default = 80
  type = number
}

variable "porta_https" {
  description = "porta http"
  default = 443
  type = number
}

resource "aws_security_group" "sg_aula_iac" {
  name = "sg_aula_iac"

  # https://ip-ranges.amazonaws.com/ip-ranges.json
  
  ingress {
    from_port = porta_http
    to_port = porta_http
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "minha_subrede" {
  vpc_id = "id da vpc"
  cidr_block = "10.10.10.0/24"
}