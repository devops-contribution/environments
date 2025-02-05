variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}
