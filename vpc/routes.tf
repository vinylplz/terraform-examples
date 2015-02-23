resource "aws_route_table" "nat" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
  tags { Name = "nat" }
}
# use nat as default (main) route: any subnet not explicitly associated with
#  another route will use this route.
resource "aws_main_route_table_association" "main_nat" {
    vpc_id = "${aws_vpc.main.id}"
    route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
  tags { Name = "public" }
}
# use public route for public subnets a,b
resource "aws_route_table_association" "public_a" {
  subnet_id = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "public_b" {
  subnet_id = "${aws_subnet.public_b.id}"
  route_table_id = "${aws_route_table.public.id}"
}
