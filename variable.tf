variable "aws_region" {
  default = "us-east-1"
}

variable "env" {
  description = "Environment (e.g., dev, prod)"
  default     = "dev"
}

variable "cidrs" {
  description = "All CIDR's Block"
  type = list(object({
    cidr = string
    name = string
  }))
}
