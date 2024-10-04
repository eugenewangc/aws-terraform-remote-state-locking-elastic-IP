terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = "S3-BUCKET-NAME"
    key = "your/path/to/key/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "DYNAMODB-TABLE-NAME"
    assume_role = {
      role_arn = "IAM-ROLE-ARN"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "example" {
  name_prefix = "example"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-05134c8ef96964280"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.example.id,
  ]
  tags = {
    Name = "ExampleAppServerInstance"
  }
}


resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.app_server.id
  allocation_id = "ALLOCATION-ID"
  allow_reassociation = true
}