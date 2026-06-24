variable "region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr              = string
    az_index          = number
    map_public_ip     = bool
  }))
  description = "Map of subnets to create"
}