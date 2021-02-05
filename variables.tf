variable "aws_profile" {
  description = "The AWS-CLI profile for the account to create resources in."
  default = "ak-terraform"
}

variable "aws_region" {
  description = "The AWS region to create resources in."
  default = "eu-west-1"
}

variable "availability_zones" {
  description = "The AWS availability zones to create subnets in."
  type = list
  default = ["eu-west-1a","eu-west-1b"]
}

variable "desired_count" {
  description = "Ideal number of instances in the ECS cluster."
  default = 1
}