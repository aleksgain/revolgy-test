resource "aws_db_instance" "revolgy-test" {
  engine         = "mysql"
  engine_version = "5.6.17"
  instance_class = "db.t1.micro"
  name           = "initial_db"
  username       = var.rds-username
  password       = var.rds-password
}

resource "mysql_user" "revolgy-test" {
  user               = var.db-username
  plaintext_password = var.db-password
}

resource "mysql_database" "revolgy-test" {
  name = "ip"
}