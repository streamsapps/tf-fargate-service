data "aws_route53_zone" "app_zone" {
  count   = "${var.r53_record_name == "" ? 0 : 1}"
  zone_id = "${var.r53_zone_id}"
}

resource "aws_route53_record" "lb-alias" {
  count   = "${var.r53_record_name == "" ? 0 : 1}"
  zone_id = "${data.aws_route53_zone.app_zone.zone_id}"
  name    = "${var.r53_record_name}.${data.aws_route53_zone.app_zone.name}"
  type    = "A"

  alias {
    name                   = "${aws_lb.alb.dns_name}"
    zone_id                = "${aws_lb.alb.zone_id}"
    evaluate_target_health = true
  }
}

output "r53_lb_alias_dns_name" {
  value = "${aws_route53_record.lb-alias.*.fqdn}"
}
