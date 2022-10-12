#---------------------------
# My terraform_remote_state
#
# Build webserver during Bootsrap
#
# Made by jeka4el
#---------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "MyWebServer" {
  name = "WebServerSG-Dynamic"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }


  # resource "aws_security_group" "MyWebServer" {
  #   name        = "WebServerSG"
  #   description = "MySG"
  #
  #   ingress {
  #     description = "http from VPC"
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  #
  #   ingress {
  #     description = "https from VPC"
  #     from_port   = 443
  #     to_port     = 443
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
  #
  #   ingress {
  #     description = "ssh from VPC"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
