locals {
  cidr_allowlist = var.waf_cidr_allowlist
}

resource "aws_waf_web_acl" "waf_acl" {
  name        = "${var.project}_waf_acl_${var.environment}"
  metric_name = "${var.project}wafacl"

  default_action {
    type = "BLOCK"
  }

  rules {
    priority = 10
    rule_id  = aws_waf_rule.ip_allowlist.id

    action {
      type = "ALLOW"
    }
  }

  depends_on = [
    "aws_waf_rule.ip_allowlist",
    "aws_waf_ipset.ip_allowlist"
  ]
}

resource "aws_waf_rule" "ip_allowlist" {

  name        = "${var.project}_ip_allowlist_rule_${var.environment}"
  metric_name = "${var.project}ipallowlist"

  depends_on = ["aws_waf_ipset.ip_allowlist"]

  predicates {
    data_id = aws_waf_ipset.ip_allowlist.id
    negated = false
    type    = "IPMatch"
  }

}

resource "aws_waf_ipset" "ip_allowlist" {
  name = "${var.project}_match_ip_allowlist_${var.environment}"


  dynamic "ip_set_descriptors" {
    for_each = toset(local.cidr_allowlist)

    content {
      type  = "IPV4"
      value = ip_set_descriptors.key
    }
  }
}