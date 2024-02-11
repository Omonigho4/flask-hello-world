resource "aws_vpc" "app_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Flask_App_vpc"
  }
}

resource "aws_subnet" "app_pub_subnet" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "App_Public_Subnet"
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "App_Igw"
  }
}

resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "App_Rt"
  }
}
resource "aws_route" "app_rt-route" {
  route_table_id         = aws_route_table.app_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.app_igw.id
}

resource "aws_route_table_association" "app_rt_association" {
  subnet_id      = aws_subnet.app_pub_subnet.id
  route_table_id = aws_route_table.app_rt.id
}