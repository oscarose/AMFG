resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "demo_tf_vpc"
        Project = "dev_environment"
    }
}

resource "aws_internet_gateway" "internal_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "demo_tf_igw"
        Project = "dev_environment"
    }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internal_gateway.id
  }

  tags = {
    Name = "demo_tf_rf"
    Project = "dev_environment"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "demo_tf_subnet_1"
    Project = "dev_environment"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "demo_tf_subnet_2"
    Project = "dev_environment"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "demo_tf_subnet_3"
    Project = "dev_environment"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  #map_private_ip_on_launch = true
  tags = {
    Name = "demo_tf_subnet_4"
    Project = "dev_environment"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  #map_private_ip_on_launch = true
  tags = {
    Name = "demo_tf_subnet_5"
    Project = "dev_environment"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]
  #map_private_ip_on_launch = true
  tags = {
    Name = "demo_tf_subnet_6"
    Project = "dev_environment"
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "public_subnet_3" {
  subnet_id = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "app" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "demo_tf_app"
    Project = "dev_environment"
  }
}

resource "aws_security_group_rule" "ingress_app_http" {
  from_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.app.id
  to_port = 80
  cidr_blocks = [
    "0.0.0.0/0"]
  type = "ingress"
}

resource "aws_security_group_rule" "ingress_app_https" {
  from_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.app.id
  to_port = 443
  cidr_blocks = [
    "0.0.0.0/0"]
  type = "ingress"
}

resource "aws_security_group_rule" "egress_app" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"]
  security_group_id = aws_security_group.app.id
}