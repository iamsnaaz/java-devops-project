variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_key_path" {
  description = "Path to your public SSH key"
}

variable "ec2_instance_type" {
  default = "t3.medium"
}
