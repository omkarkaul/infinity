terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.64"
        }
    }

    required_version = "~> 1.0"

    backend "s3" {
        bucket = "infinity-tf-bucket"
        key = "infinity.tfstate"
        region = "ap-southeast-2"
        dynamodb_table = "infinity-tf-state-lock"
        encrypt = true
    }
}

provider "aws" {
    profile = "default"
    region = "ap-southeast-2"
}

