# SECURITY GROUPS
#
# Argument Reference
# name - (Required) The name of the security group
# description - (Required) The security group description.
# ingress - (Optional) Can be specified multiple times for each ingress rule.
#           Each ingress block supports fields documented below.
# egress - (Optional) Can be specified multiple times for each egress rule.
#           Each egress block supports fields documented below. VPC only.
# vpc_id - (Optional) The VPC ID.
# owner_id - (Optional) The AWS Owner ID.

# The ingress block supports:
# cidr_blocks - (Optional) List of CIDR blocks. Cannot be used with
#                          security_groups.
# from_port - (Required) The start port.
# protocol - (Required) The protocol.
# security_groups - (Optional) List of security group IDs. Cannot be used with
#                              cidr_blocks.
# self - (Optional) If true, the security group itself will be added as a
#                   source to this ingress rule.
# to_port - (Required) The end range port.
# tags - (Optional) A mapping of tags to assign to the resource.

# The egress block supports:
# cidr_blocks - (Optional) List of CIDR blocks. Cannot be used with
#                security_groups.
# from_port - (Required) The start port.
# protocol - (Required) The protocol.
# security_groups - (Optional) List of security group IDs. Cannot be used with
#                    cidr_blocks.
# self - (Optional) If true, the security group itself will be added as a
#                   source to this egress rule.
# to_port - (Required) The end range port.
# tags - (Optional) A mapping of tags to assign to the resource.
# 

resource "aws_security_group" "elb_web" {
  name = "elb_web"
  description = "security group for web elbs"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "nat" {
  name = "nat"
  description = "nat security group"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web" {
  name = "web"
  description = "security group for web servers"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb_web.id}"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.nat.id}"]
  }
}

