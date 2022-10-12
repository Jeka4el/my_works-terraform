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

resource "aws_eip" "my_static_ip" {      # Создаю бетый  IP
  instance = aws_instance.MyWebServer.id # привязываю к id инстанса
}


resource "aws_instance" "MyWebServer" {
  ami                    = "ami-08658d5197becde34"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.MyWebServer.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Jeka",
    l_name = "4el",
    names  = ["Jorik", "Misha", "Alena", "Jeny", "Lena", "Oly", "Ura"]
  })


  tags = {
    Name  = "WebApache"
    Owner = "Jeka4el"
  }


  # lifecycle {
  #   #prevent_destroy = true # по дефорлу false, не true не дает убить ресурс.
  #   #ignore_changes = ["ami", "user_data"] # игнорировать измининия в этих ресурсах.
  #   create_before_destroy = true # сначала создает новый сервак, потом делает destroy.
  # }
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
