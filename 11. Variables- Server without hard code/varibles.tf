variable "region" {
  description = "Please Enter AWS Region to deploy Server" # При apply будет просить ввести данные region
  default     = "eu-central-1"                             # при добавлении default, загрузиться default
}

variable "instance_type" {
  description = "Please Enter Instance Type"
  type        = string # type = string по дефолту, можно не писать
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "List of Ports to open server"
  type        = list(any)
  default     = ["80", "443", "22"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = "true"
}

variable "common-tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Owner      = "Jeka4el"
    Project    = "my_education"
    Envirement = "Staging"

  }
}
