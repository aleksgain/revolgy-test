resource "aws_lb_target_group" "revolgy-test" {
  name = "revolgy-test"
  port = 31337
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = aws_vpc.app-vpc.id

  health_check {
    enabled = true
    path = "/health"
  }

  depends_on = [aws_alb.revolgy-test]
}

resource "aws_alb" "revolgy-test" {
  name = "revolgy-test-lb"
  internal = false
  load_balancer_type = "application"

  subnets = [
    aws_subnet.public.id,
    aws_subnet.private.id,
  ]

  security_groups = [
    aws_security_group.http.id, 
    aws_security_group.egress-all.id,
  ]

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_alb_listener" "revolgy-test-http" {
  load_balancer_arn = aws_alb.revolgy-test.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.revolgy-test.arn
  }
}