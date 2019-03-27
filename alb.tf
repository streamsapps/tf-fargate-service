resource "aws_lb" "alb" {
  name               = "${var.load_balancer_name}"
  internal           = "${var.alb_internal}"
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = ["${split(",", var.alb_security_groups)}"]
  subnets            = ["${split(",", var.alb_subnets)}"]
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.target_group_name}"
  port        = "${var.load_balancer_target_port}"
  protocol    = "${var.load_balancer_target_protocol}"
  vpc_id      = "${var.vpc_id}"
  target_type = "ip"

  health_check {
    path = "${var.healthcheck_path}"
  }

  depends_on = ["aws_lb.alb"]
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  #TODO: When certs are a thing change this to HTTPS
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }
}
