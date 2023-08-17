terraform {
  required_providers {
    namecheap = {
      source  = "namecheap/namecheap"
      version = "2.1.0"
    }
  }
}

locals {
  mx_records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM"
  ]

  records = concat(var.records, [
    {
      name = ""
      type = "TXT"
      records = [
        "google-site-verification=${var.google}"
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

resource "namecheap_domain_records" "domain" {
  domain = var.domain
  mode   = "OVERWRITE"

  nameservers = aws_route53_zone.zone.name_servers
}

resource "aws_route53_record" "record" {
  for_each = { for record in local.records : "${record.name}.${var.domain}_${record.type}" => record }

  zone_id = aws_route53_zone.zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}
