variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnets"
}

variable "env" {
  type        = string
  description = "Environment"
}
