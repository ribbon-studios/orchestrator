locals {
  github_pages_ipv4 = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]

  github_pages_ipv6 = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153",
  ]

  mx_records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM"
  ]
}

module "cecilias_me" {
  source = "./modules/zone"
  domain = "cecilias.me"

  records = [
    {
      type = "TXT"
      records = [
        "google-site-verification=pFsrSZl3l9vbQScTjdtXieVHE1Ce8pkMkZRagaVlzxA"
      ]
    },
    {
      type    = "MX",
      records = local.mx_records,
      ttl     = 3600
    },
    {
      type    = "A"
      records = local.github_pages_ipv4
    },
    {
      type    = "AAAA"
      records = local.github_pages_ipv6
    },
    {
      name    = "github"
      type    = "CNAME"
      records = ["https://github.com/cecilia-sanare"]
    },
    {
      name    = "origins"
      type    = "A"
      records = [var.SERVER_IP_ADDRESS]
    },
  ]
}

module "rains_cafe" {
  source = "./modules/zone"
  domain = "rains.cafe"

  records = [
    {
      type = "TXT"
      records = [
        "google-site-verification=8n2S6aE0zRfPbVTwhknvMfENZH28tVnlLB60SlxFXwY"
      ]
    },
    {
      type    = "MX",
      records = local.mx_records,
      ttl     = 3600
    },
    {
      type    = "A"
      records = local.github_pages_ipv4
    },
    {
      type    = "AAAA"
      records = local.github_pages_ipv6
    },
    {
      name    = "origins.mc"
      type    = "A"
      records = [var.SERVER_IP_ADDRESS]
    },
    {
      name    = "*.staging"
      type    = "A"
      records = [var.SERVER_IP_ADDRESS]
    },
    {
      name    = "www"
      type    = "CNAME"
      records = ["rain-cafe.github.io"]
    },
    {
      name    = "silvy"
      type    = "CNAME"
      records = ["rain-silvy.netlify.app"]
    },
    {
      name    = "utils"
      type    = "CNAME"
      records = ["rain-cafe-utils.netlify.app"]
    },
    {
      name    = "refreshly"
      type    = "CNAME"
      records = ["9d61994484-hosting.gitbook.io"]
    }
  ]
}
