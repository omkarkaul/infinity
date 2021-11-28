resource "aws_ecr_repository" "infinity_ecr" {
  name = "${var.app_name}-${var.environment}-ecr"
  tags = {
    Name        = "${var.app_name}-ecr"
    Environment = var.environment
  }
}