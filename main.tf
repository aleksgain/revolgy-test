resource "aws_ecs_cluster" "revolgy-test-cluster" {
  name = "revolgy-test-cluster"
}

resource "aws_ecs_service" "revolgy-test" {
  name = "revolgy-test-app"
  cluster = aws_ecs_cluster.revolgy-test-cluster.id
  task_definition = aws_ecs_task_definition.revolgy-test.arn
  launch_type = "FARGATE"
  desired_count = var.desired_count
  network_configuration {
   assign_public_ip = false

   security_groups = [
    aws_security_group.egress-all.id,
    aws_security_group.http.id,
   ]

   subnets = [
    aws_subnet.private.id,
   ]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.revolgy-test.arn
    container_name = "revolgy-test"
    container_port = "31337"
  }
  depends_on = [module.db.this_db_instance_name]
}

resource "aws_ecs_task_definition" "revolgy-test" {
  family = "revolgy-test"
  container_definitions = << EOF
  [
    {
      "name": "revolgy-test",
      "image": "aleksgain/revolgy-test:latest",
      "portMappings": [
        {
          "containerPort": 31337
        }
      ],
      "environment": [
        {
          "name": "USER", 
          "value": "${jsonencode(var.rds-username)}"
        },
        {
          "name": "PASSWORD",
          "value": "${jsonencode(var.rds-password)}"
        },
        {
          "name": "DB-HOST",
          "value": "${jsonencode(module.db.this_db_instance_address)}"
        },
        {
          "name": "DB-NAME",
          "value": "${jsonencode(var.rds-dbname)}"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "eu-west-1",
          "awslogs-group": "/ecs/revolgy-test",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
]
EOF
  execution_role_arn = aws_iam_role.revolgy-test-execution-role.arn
  cpu = 256
  memory = 512
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"
  depends_on = [module.db.this_db_instance_name]
}

resource "aws_iam_role" "revolgy-test-execution-role" {
  name = "revolgy-test-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs-task-assume-role.json
}

data "aws_iam_policy_document" "ecs-task-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ecs-task-execution-role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role" {
  role = aws_iam_role.revolgy-test-execution-role.name
  policy_arn = data.aws_iam_policy.ecs-task-execution-role.arn
}

resource "aws_cloudwatch_log_group" "revolgy-test" {
  name = "/ecs/revolgy-test"
}