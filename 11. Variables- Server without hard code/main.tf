
provider "aws" {
  region = var.region
}


# resource "aws_default_vpc" "default" {}

data "aws_availability_zones" "available" {}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # нащел в консоле, развернул ami нужный, вместо концовки поставил *
  }

}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_server.id
  tags     = merge(var.common-tags, { Name = "${var.common-tags["Envirement"]} Server IP" })

}

resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  monitoring             = var.enable_detailed_monitoring #true -Будет отправлять данные каждую минут, платная тема.

  tags = merge(var.common-tags, { Name = "my_server" }) #  Соединил таг ручной и из переменных.
  #   tags = {
  #     Name    = "Server IP"
  #     Owner   = "Jeka4el"
  #     Project = "my_education"
  #   }
  #
  # }
}

resource "aws_security_group" "web" {
  name = "WebServerSG-Dynamic"
  #vpc_id = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = merge(var.common-tags, { Name = "Dynamic-http-https-ssh" })

}
