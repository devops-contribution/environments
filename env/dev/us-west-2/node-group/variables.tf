variable "node_group_name"{
  type = string
}

variable "instance_types" {
  type = string
}

variable "desired_size" {
  type = int
}
variable "max_size" {
  type = int
}

variable  "min_size" {
  type = int
}
