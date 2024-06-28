# variables.tf content for vpc/
variable "cidr_block" {
  type = string
  description = "Plage cidr pour le vpc"
  default = "192.168.0.0/24"
}

variable "cidr_block_public_subnet_a" {
  type = string
  description = "Plage cidr pour le public subnet a "
  default = "192.168.1.0/24"
}

variable "cidr_block_public_subnet_b" {
  type = string
  description = "Plage cidr pour le public subnet b"
  default = "192.168.2.0/24"
}

variable "cidr_block_public_subnet_c" {
  type = string
  description = "Plage cidr pour le public subnet c"
  default = "192.168.3.0/24"
}

variable "cidr_block_private_subnet_a" {
  type = string
  description = "Plage cidr pour le private subnet a "
  default = "192.168.11.0/24"
}

variable "cidr_block_private_subnet_b" {
  type = string
  description = "Plage cidr pour le private subnet b"
  default = "192.168.12.0/24"
}

variable "cidr_block_private_subnet_c" {
  type = string
  description = "Plage cidr pour le private subnet c"
  default = "192.168.13.0/24"
}





