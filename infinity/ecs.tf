resource "aws_ecs_cluster" "infinity" {
  name = "${var.app_name}-cluster"
}