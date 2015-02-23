# Argument Reference
# name - (Required) The name of the ELB
# availability_zones - (Required for an EC2-classic ELB) The AZ's to serve
#  traffic in.
# security_groups - (Optional) A list of security group IDs to assign to the ELB.
# subnets - (Required for a VPC ELB) A list of subnet IDs to attach to the ELB.
# instances - (Optional) A list of instance ids to place in the ELB pool.
# internal - (Optional) If true, ELB will be an internal ELB.
# listener - (Required) A list of listener blocks. Listeners documented below.
# health_check - (Optional) A health_check block. Health Check documented below.
# cross_zone_load_balancing - (Optional) Enable cross-zone load balancing.
# Exactly one of availability_zones or subnets must be specified: this
#  determines if the ELB exists in a VPC or in EC2-classic.
# 
# Listeners support the following:
# instance_port - (Required) The port on the instance to route to
# instance_protocol - (Required) The the protocol to use to the instance.
# lb_port - (Required) The port to listen on for the load balancer
# lb_protocol - (Required) The protocol to listen on.
# ssl_certificate_id - (Optional) The id of an SSL certificate you have
#  uploaded to AWS IAM.
# 
# Health Check supports the following:
# healthy_threshold - (Required) The number of checks before the instance is
#  declared healthy.
# unhealthy_threshold - (Required) The number of checks before the instance is
#  declared unhealthy.
# target - (Required) The target of the check.
# interval - (Required) The interval between checks.
# timeout - (Required) The length of time before the check times out.
# 
resource "aws_elb" "web" {
  name = "web"
  subnets = ["${aws_subnet.public_a.id}",
             "${aws_subnet.public_b.id}"]
  security_groups = ["${aws_security_group.elb_web.id}"]
  cross_zone_load_balancing = "true"
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
#   listener {
#     instance_port = 80
#     instance_protocol = "http"
#     lb_port = 443
#     lb_protocol = "https"
#     ssl_certificate_id = "FIXME"
#   }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    target = "HTTP:80/"
    interval = 30 
    timeout = 3
  }
  # instances are defined in the auto scaling group config. see web.tf
}
