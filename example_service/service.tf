resource "aws_ecs_service" "example_service" {
  name            = "example-service"
  cluster         = local.infinity_vpc_id
  task_definition = aws_ecs_task_definition.example_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.example_task_security.id]
    subnets         = local.private_subnet_ids
  }

  load_balancer {
    target_group_arn = local.elb_target_arn
    container_name   = "example-container"
    container_port   = 3000
  }
}

