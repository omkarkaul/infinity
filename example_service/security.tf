resource "aws_security_group" "example_task_security" {
    name = "example-task-security-group"
    vpc_id = aws_vpc.infinity_vpc.id

    ingress {
        protocol = "tcp"
        from_port = 3000
        to_port = 3000
        security_groups = [aws_security_group.elb_security.id]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}