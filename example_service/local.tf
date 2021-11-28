locals {
    infinity_vpc_id = data.terraform_remote_state.infinity.outputs.infinity_vpc_id
    elb_security_id = data.terraform_remote_state.infinity.outputs.elb_security_id
    ecr_repo_url = data.terraform_remote_state.infinity.outputs.ecr_repo_url
    private_subnet_ids = data.terraform_remote_state.infinity.outputs.private_subnet_ids
    elb_target_arn = data.terraform_remote_state.infinity.outputs.elb_target_arn
}