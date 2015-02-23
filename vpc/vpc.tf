provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "main"
  }
}

### NAT HOSTS
resource "aws_instance" "nat" {
  ami = "ami-224dc94a"         # amzn-ami-vpc-nat-pv-2014.09.1.x86_64-ebs 
  instance_type = "m1.small"
  subnet_id = "${aws_subnet.public_a.id}"
  security_groups = ["${aws_security_group.nat.id}"]
 # see: http://amzn.to/1EF5WkO
  /* NASTY BUG terraform v0.3.7
     source dest check always set to true on initial creation.  this breaks
     the NAT, meaning none of your instances in the private subnet can 
     access the internet or update packages from public repos.  to fix,
     either toggle it true then false, or fix it manually in the GUI */
  source_dest_check = false 
  key_name = "terraform"
}

