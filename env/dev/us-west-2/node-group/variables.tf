variable "node_group_name"{
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "desired_size" {
  type = number
}
variable "max_size" {
  type = number
}

variable  "min_size" {
  type = number
}

variable "bucket_name" {
  type = string
}

variable "region" {
  type = string
}
