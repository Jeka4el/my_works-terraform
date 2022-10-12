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

resource "aws_instance" "MyWebServer" {
  ami                    = "ami-08658d5197becde34"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.MyWebServer.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
sudo service httpd start
chkconfig httpd on
EOF


  tags = {
    Name = "httpd"
  }
}

resource "aws_security_group" "MyWebServer" {
  name        = "WebServerSG"
  description = "MySG"

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https from VPC"
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
