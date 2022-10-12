provider "aws" {
  region = "eu-central-1"
}


resource "null_resource" "command1" { # запускаю обычную Linux команду
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }

  depends_on = [null_resource.command1] # зависит от resource "null_resource" "command1"
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command     = "print('Hello World from python')"
    interpreter = ["python3", "-c"] # какая прога запускает и аргумент
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
    environment = {
      NAME1 = "Jeka"
      NAME2 = "4el"
      NAME3 = "Jeka4el"
    }
  }
}

resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo Terraform END: $(date) >> log.txt"
  }
  depends_on = [null_resource.command1, null_resource.command2, null_resource.command3, null_resource.command4, null_resource.command5]
}
