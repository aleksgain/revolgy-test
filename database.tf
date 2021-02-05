module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "revolgy-test-db"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  name     = "ip"
  username = var.rds-username
  password = var.rds-password
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_vpc.app-vpc.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  monitoring_interval = "30"
  monitoring_role_name = "RDSMonitoringRole"
  create_monitoring_role = true

  subnet_ids = [
    aws_subnet.public.id,
    aws_subnet.private.id,
  ]

  family = "mysql5.7"

  major_engine_version = "5.7"

  deletion_protection = false

  parameters = [
    {
      name = "character_set_client"
      value = "utf8"
    },
    {
      name = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}