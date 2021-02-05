provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "mysql" {
  endpoint = aws_db_instance.revolgy-test.endpoint
  username = var.db-username
  password = var.db-password
}