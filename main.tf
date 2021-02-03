resource "aws_ecs_cluster" "revolgy-test-cluster" {
  name = "revolgy-test-cluster"
}

resource "aws_ecs_service" "revolgy-test" {
  name = "revolgy-test-1"
  cluster = aws_ecs_cluster.revolgy-test-cluster.id
  task_definition = aws_ecs_task_definition.revolgy-test.arn
  launch_type = "FARGATE"
}

resource "aws_cloudwatch_log_group" "revolgy-test" {
  name = "/ecs/revolgy-test"
}

resource "aws_ecs_task_definition" "revolgy-test" {
  family = "revolgy-test"
  container_definitions = file("revolgy-test-container.json")
  execution_role_arn = aws_iam_role.revolgy-test-execution-role.arn
  cpu = 256
  memory = 512
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"
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