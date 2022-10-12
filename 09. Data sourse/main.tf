provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "latest_ubuntu" { # ищет последнюю убутну jammy
  owners      = ["099720109477"] # нащел в консоле, развернул ami нужный и посмотрел кто owner
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # нащел в консоле, развернул ami нужный, вместо концовки поставил *
  }

}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}
output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {} # current это название, можно любое написать.
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}

output "aws_availability_zones" {
  value = data.aws_availability_zones.working.names #[0] #выведет только первый регион
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = data.aws_region.current.name
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}


data "aws_vpc" "my_aws_vpc" {
  tags = {                             #
    Name = "jeka4el-network-world-VPC" # jeka4el-network-world-VPC уже была создана руками, в консоли.
  }
}

output "aws_vpc_id" {
  value = data.aws_vpc.my_aws_vpc.id
}

output "aws_vpc_cidr" {
  value = data.aws_vpc.my_aws_vpc.cidr_block
}

resource "aws_subnet" "jeka4elnetwork-subworld-1" {
  vpc_id            = data.aws_vpc.my_aws_vpc.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block        = "10.0.1.0/24" # посмотрел ip в консоле
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.working.names[0]}"
    Account = "Subnrt in Account ${data.aws_caller_identity.current.account_id}"
  }
}

resource "aws_subnet" "jeka4elnetwork-subworld-2" {
  vpc_id            = data.aws_vpc.my_aws_vpc.id
  availability_zone = data.aws_availability_zones.working.names[1]
  cidr_block        = "10.0.2.0/24" # посмотрел ip в консоле
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.working.names[1]}"
    Account = "Subnrt in Account ${data.aws_caller_identity.current.account_id}"
  }
}
