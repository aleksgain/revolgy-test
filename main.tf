resource "aws_ecs_service" "revolgy-test" {
  name            = "revolgy-test"
  task_definition = "aws_ecs_task_definition.revolgy-test.arn"
  launch_type     = "FARGATE"
}

resource "aws_cloudwatch_log_group" "revolgy-test" {
  name = "/ecs/revolgy-test"
}

resource "aws_ecs_task_definition" "revolgy-test" {
  family = "revolgy-test"

  container_definitions = <<EOF
  [
    {
      "name": "revolgy-test",
      "image": "aleksgain/revolgy-test:latest",
      "portMappings": [
        {
          "containerPort": 80
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

  cpu = 256
  memory = 512
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"
}