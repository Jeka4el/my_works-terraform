provider "aws" {
  #access_key = "11111" ===> export AWS_ACCESS_KEY_ID=11111
  #secret_key = "22222" ===> export AWS_SECRET_ACCESS_KEY=22222
  region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-02d63d6d135e3f0f0"
  instance_type = "t2.micro"
  count         = 1

  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "jeka4el"
    Project = "education"
  }
}

resource "aws_instance" "my_amazon" {
  ami           = "ami-0087bd2f5c26af5ca"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "jeka4el"
    Project = "education"
  }

}
