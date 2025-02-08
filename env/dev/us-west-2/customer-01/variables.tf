variable "project_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_az1_cidr" {
  type = string
}

variable "public_subnet_az2_cidr" {
  type = string
}

variable "ssh_access" {
  type = list(string)
}

variable "http_access" {
  type = list(string)
}

variable "instance_size" {
  type = string
}
