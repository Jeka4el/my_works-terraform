provider "aws" {
  region = "eu-central-1"
}


resource "aws_iam_user" "user1" { #создаю юзера в aws
  name = "Panas"
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)               # Пробегаюсь по списку aws_users
  name  = element(var.aws_users, count.index) # count.index выводит имена
}

#----------------------------------------------------------------

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-02d63d6d135e3f0f0"
  instance_type = "t2.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}
