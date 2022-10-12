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

resource "aws_instance" "WebServer" {
  ami                    = "ami-02d63d6d135e3f0f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.MyWebServer.id]

  tags = {
    Name    = "Web Server"
    Owner   = "jeka4el"
    Project = "education"
  }

  depends_on = [aws_instance.DB_server, aws_instance.AppServer] # WebServer будет создан после DB_server и AppServer будет создан последний
}

resource "aws_instance" "AppServer" {
  ami                    = "ami-02d63d6d135e3f0f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.MyWebServer.id]

  tags = {
    Name    = "Server-Application"
    Owner   = "jeka4el"
    Project = "education"
  }

  depends_on = [aws_instance.DB_server] # AppServer будет создан после DB_server
}

resource "aws_instance" "DB_server" {
  ami                    = "ami-02d63d6d135e3f0f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.MyWebServer.id]

  tags = {
    Name    = "DB Server"
    Owner   = "jeka4el"
    Project = "education"
  }
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


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
