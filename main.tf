resource "aws_route53_zone" "main" {
  name = "${var.domain_name}"
  comment = "${var.comment}"
}

resource "aws_route53_record" "primary" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.subdomain}"
  type    = "A"
  ttl     = "${var.ttl}"

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier = "${var.identifier1}"
  records        = ["${var.primaryip}"]
  health_check_id = "${aws_route53_health_check.primary.id}"
}

resource "aws_route53_record" "secondary" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.subdomain}"
  type    = "A"
  ttl     = "${var.ttl}"

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "${var.identifier2}"
  records        = ["${var.secondaryip}"]
  health_check_id = "${aws_route53_health_check.secondary.id}"
}

resource "aws_route53_health_check" "primary" {
  ip_address        = "${var.primaryip}"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "2"
  request_interval  = "30"

  tags = {
    Name = "route53-primary-health-check"
  }
}

resource "aws_route53_health_check" "secondary" {
  ip_address        = "${var.secondaryip}"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "2"
  request_interval  = "30"

  tags = {
    Name = "route53-secondary-health-check"
  }
}

