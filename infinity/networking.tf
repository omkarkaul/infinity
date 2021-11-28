## VPC
resource "aws_vpc" "infinity_vpc" {
    cidr_block = var.cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
        Name = "${var.app_name}-vpc"
        Environment = var.environment
    }
}

## SUBNETS
resource "aws_subnet" "private" {
    # two private subnets created using "count" meta-arg
    vpc_id = aws_vpc.infinity_vpc.id
    count = length(var.private_subnets)
    cidr_block = element(var.private_subnets, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "${var.app_name}-private-subnet-${count.index + 1}"
        Environment = var.environment
    }
}

resource "aws_subnet" "public" {
    # two public subnets created using "count" meta-arg
    vpc_id = aws_vpc.infinity_vpc.id
    count = length(var.public_subnets)
    cidr_block = element(var.public_subnets, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "${var.app_name}-public-subnet-${count.index + 1}"
        Environment = var.environment
    }
}

## GATEWAYS & IP's
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.infinity_vpc.id
}

resource "aws_eip" "elastic_ips" {
    count = 2
    vpc = true
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
    count = 2
    subnet_id = element(aws_subnet.public.*.id, count.index)
    allocation_id = element(aws_eip.elastic_ips.*.id, count.index)
}

## ROUTING
resource "aws_route_table" "route_table" {
    # routes any private ipv4 traffic to the NAT gateway
    count = 2
    vpc_id = aws_vpc.infinity_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
    }
}

resource "aws_route_table_association" "private_association" {
    count = 2
    subnet_id = element(aws_subnet.private.*.id, count.index)
    route_table_id = element(aws_route_table.route_table.*.id, count.index)
}

resource "aws_route" "internet" {
    # routes any public ipv4 traffic to the IGW
    # applies to the main route table, which by default attaches to our two public subnets
    route_table_id = aws_vpc.infinity_vpc.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}