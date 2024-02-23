locals {
  mx_records = [
    "10 in1-smtp.messagingengine.com",
    "20 in2-smtp.messagingengine.com",
  ]

  records = concat(var.records, [
    {
      name = ""
      type = "TXT"
      records = [
        "v=spf1 include:spf.messagingengine.com ?all"
      ]
      ttl = 300
    },
    {
      name = "fm1._domainkey"
      type = "CNAME"
      records = [
        "fm1.${var.domain}.dkim.fmhosted.com"
      ]
      ttl = 300
    },
    {
      name = "fm2._domainkey"
      type = "CNAME"
      records = [
        "fm2.${var.domain}.dkim.fmhosted.com"
      ]
      ttl = 300
    },
    {
      name = "fm3._domainkey"
      type = "CNAME"
      records = [
        "fm3.${var.domain}.dkim.fmhosted.com"
      ]
      ttl = 300
    },
    {
      name    = ""
      type    = "MX",
      records = local.mx_records,
      ttl     = 3600
    },
  ])
}

resource "aws_route53_zone" "zone" {
  name = var.domain

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "record" {
  for_each = { for record in local.records : "${record.name}.${var.domain}_${record.type}" => record }

  zone_id = aws_route53_zone.zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}

output "name_servers" {
  value = aws_route53_zone.zone.name_servers
}
