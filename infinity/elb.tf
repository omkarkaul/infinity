resource "aws_security_group" "elb_security" {
    name = "${var.app_name}-elb-security-group"
    vpc_id = aws_vpc.infinity_vpc.id

    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol = "-1" # any protocol
        from_port = 0 # any port
        to_port = 0 # any port
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_lb" "elb" {
    name = "${var.app_name}-elb"
    load_balancer_type = "application"
    subnets = aws_subnet.public.*.id
    security_groups = [aws_security_group.elb_security.id]
}

resource "aws_lb_target_group" "elb_target_group" {
    name = "${var.app_name}-elb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.infinity_vpc.id
    target_type = "ip"
}

resource "aws_lb_listener" "elb_listener" {
    load_balancer_arn = aws_lb.elb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_lb_target_group.elb_target_group.arn
        type = "forward"
    }
}
