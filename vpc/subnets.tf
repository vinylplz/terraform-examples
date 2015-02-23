# Argument Reference
# availability_zone- (Optional) The AZ for the subnet.
# cidr_block - (Required) The CIDR block for the subnet.
# map_public_ip_on_launch - (Optional) Specify true to indicate that instances
#              launched into the subnet should be assigned a public IP address
# vpc_id - (Required) The VPC ID.
# tags - (Optional) A mapping of tags to assign to the resource.
# 

# Subnets should be kept in CIDR order, not alphabetically

### PUBLIC SUBNETS
resource "aws_subnet" "public_a" {
   cidr_block = "10.0.0.0/24"
   availability_zone = "${var.zone.a}"
   vpc_id = "${aws_vpc.main.id}"
   map_public_ip_on_launch = "true"
   tags { Name = "public_a" }
} 

resource "aws_subnet" "public_b" {
   cidr_block = "10.0.1.0/24"
   availability_zone = "${var.zone.b}"
   vpc_id = "${aws_vpc.main.id}"
   map_public_ip_on_launch = "true"
   tags { Name = "public_b" }
} 

resource "aws_subnet" "web_a" {
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.zone.a}"
  vpc_id = "${aws_vpc.main.id}"
  tags { Name = "web_a" }
}

resource "aws_subnet" "web_b" {
  cidr_block = "10.0.3.0/24"
  availability_zone = "${var.zone.b}"
  vpc_id = "${aws_vpc.main.id}"
  tags { Name = "web_b" }
}


