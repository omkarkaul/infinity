output "infinity_vpc_id" {
    value = aws_vpc.infinity_vpc.id
}

output "elb_security_id" {
    value = aws_security_group.elb_security.id
}

output "ecr_repo_url" {
    value = aws_ecr_repository.infinity_ecr.repository_url
}

output "private_subnet_ids" {
    value = aws_subnet.private.*.id
}

output "elb_target_arn" {
    value = aws_lb_target_group.elb_target_group.arn
}