resource "aws_lb" "alb" {
  name               = "${var.load_balancer_name}"
  internal           = "${var.alb_internal}"
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = "${var.alb_security_groups}"
  subnets            = "${var.alb_subnets}"
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.target_group_name}"
  port        = "${var.load_balancer_target_port}"
  protocol    = "${var.load_balancer_target_protocol}"
  vpc_id      = "${var.vpc_id}"
  target_type = "ip"

  health_check {
    port                = "${var.healthcheck_port}"
    path                = "${var.healthcheck_path}"
    timeout             = "${var.healthcheck_timeout_seconds}"
    healthy_threshold   = "${var.healthcheck_healthy_threshold}"
    unhealthy_threshold = "${var.healthcheck_unhealthy_threshold}"
    interval            = "${var.healthcheck_interval_seconds}"
  }

  depends_on = ["aws_lb.alb"]
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "${var.ssl_certificate_id}"
  ssl_policy        = "${var.ssl_policy}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }
}

resource "aws_lb_listener" "http_to_https" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

output "alb_arn" {
  value       = "${aws_lb.alb.arn}"
  description = "arn of alb created"
}
