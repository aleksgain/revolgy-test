terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "ak-terraform-store-1"
    key = "terraform.state"
    region = "eu-west-1"
    profile = "ak-terraform"
  }
}