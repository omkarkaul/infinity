variable "app_name" {
  type = string
  description = "Name of the application"
}

variable "environment" {
    type = string
    description = "The application environment"
}

variable "cidr" {
    type = string
    description = "The CIDR block for the VPC"
}

variable "public_subnets" {
    description = "List of public subnets"
}

variable "private_subnets" {
    description = "List of private subnets"
}

variable "availability_zones" {
    description = "List of availability zones"
}