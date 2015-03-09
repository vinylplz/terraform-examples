

# resource "aws_instance" "example" {
#   ami = "ami-aa7ab6c2"
#   instance_type = "t1.micro"
#   subnet_id = "${aws_subnet.web_a.id}"
#   security_groups = ["${aws_security_group.web.id}"]
# }

resource "aws_launch_configuration" "web" {
  name = "web"
  image_id = "ami-aa7ab6c2"
  instance_type = "t1.micro"
  security_groups = ["${aws_security_group.web.id}"]
#    iam_instance_profile = FIXME
  key_name = "${var.ssh_key}"
  user_data = "#!/bin/bash\nsudo apt-get update && sudo apt-get install -y apache2"
}

resource "aws_autoscaling_group" "web" {
  availability_zones = ["${var.zone.a}","${var.zone.b}"]
  name = "web"
  max_size = 4
  min_size = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 2
  force_delete = true
  launch_configuration = "${aws_launch_configuration.web.name}"
  load_balancers = ["${aws_elb.web.id}"]
  vpc_zone_identifier = ["${aws_subnet.web_a.id}",
                         "${aws_subnet.web_b.id}"]
}

