resource "aws_ecs_service" "revolgy-test" {
  name            = "revolgy-test"
  task_definition = ""
  launch_type     = "FARGATE"
}