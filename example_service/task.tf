resource "aws_ecs_task_definition" "example_task" {
  family = "example-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"

  container_definitions = <<DEFINITION
[
  {
    "name": "example-container",
    "image": "${local.ecr_repo_url}/example-image:latest",
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "cpu": 1024,
    "memory": 2048,
    "networkMode": "awsvpc"
  }
]
DEFINITION
}