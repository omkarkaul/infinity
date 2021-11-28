resource "aws_ecs_service" "example_service" {
  name            = "example-service"
  cluster         = aws_ecs_cluster.infinity_vpc.id
  task_definition = aws_ecs_task_definition.example_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.example_task_security.id]
    subnets         = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.elb_target_group.arn
    container_name   = "example-container"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.elb_listener]
}

