resource "aws_route53_zone" "zone" {
  name = var.domain

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "record" {
  for_each = {for record in var.records: "${record.name}.${var.domain}_${record.type}" => record}

  zone_id  = aws_route53_zone.zone.zone_id
  name     = each.value.name
  type     = each.value.type
  ttl      = each.value.ttl
  records  = each.value.records
}
