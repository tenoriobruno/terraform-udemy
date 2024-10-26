variable "cidr_subnet" {
  description = "Cidr da Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "cidr_subnet_vpc_remote" {
  description = "Cidr da Subnet"
  type        = string
  default     = "172.31.1.0/24"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}


