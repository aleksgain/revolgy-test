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
  description = "Desired number of instances in the ECS cluster."
  default = 1
}

variable "ecs-cpu-size" {
  description = "Desired CPU size"
  default = 256
}

variable "ecs-ram-size" {
  description = "Desired memory size"
  default = 512
}

variable "rds-dbname" {
    description = "Default database name"
    default = "ip"
}

variable "rds-username" {
    description = "Username for RDS MySQL databse"
}

variable "rds-password" {
    description = "Password for RDS MySQL databse"
}

variable "db-storage-size" {
    description = "Desired database size, in GB"
    default = 5
}

variable "db-instance-type" {
    description = "Desired instance type for RDS database"
    default = "db.t3.micro"
}