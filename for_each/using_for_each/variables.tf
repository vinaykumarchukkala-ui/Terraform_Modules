variable "region" {}

variable "project_name" {}

variable "vpc_cidr" {}

variable "subnets" {
  type = map(object({
    cidr              = string
    az_index          = number
    map_public_ip     = bool
  }))
  default = {
    "public-subnet-az1" = {
      cidr          = "10.0.1.0/24"
      az_index      = 0
      map_public_ip = true
    }
    "public-subnet-az2" = {
      cidr          = "10.0.2.0/24"
      az_index      = 1
      map_public_ip = true
    }
    "private-app-subnet-az1" = {
      cidr          = "10.0.11.0/24"
      az_index      = 0
      map_public_ip = false
    }
    "private-app-subnet-az2" = {
      cidr          = "10.0.12.0/24"
      az_index      = 1
      map_public_ip = false
    }
    "private-data-subnet-az1" = {
      cidr          = "10.0.21.0/24"
      az_index      = 0
      map_public_ip = false
    }
    "private-data-subnet-az2" = {
      cidr          = "10.0.22.0/24"
      az_index      = 1
      map_public_ip = false
    }
  }
}