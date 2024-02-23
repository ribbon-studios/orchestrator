data "github_ip_ranges" "latest" {}

locals {
  allowed_ip_ranges_ipv4 = [for github_cidr in data.github_ip_ranges.latest.pages_ipv4 : replace(github_cidr, "/32", "")]
  allowed_ip_ranges_ipv6 = [for github_cidr in data.github_ip_ranges.latest.pages_ipv6 : replace(github_cidr, "/128", "")]
}

module "cecilias_me" {
  source = "./modules/zone"
  domain = "cecilias.me"

  records = [{
    name    = "github"
    type    = "CNAME"
    records = ["https://github.com/cecilia-sanare"]
    }, {
    name    = "atm"
    type    = "A"
    records = [var.MC_IP_ADDRESS]
    }, {
    name    = "smp"
    type    = "A"
    records = [var.MC_IP_ADDRESS]
    }, {
    name    = "origins"
    type    = "A"
    records = [var.MC_IP_ADDRESS]
  }]
}

module "rains_cafe" {
  source = "./modules/zone"
  domain = "rains.cafe"

  records = [
    {
      name    = "@"
      type    = "A"
      records = local.allowed_ip_ranges_ipv4
    },
    {
      name    = "@"
      type    = "AAAA"
      records = local.allowed_ip_ranges_ipv6
    }
  ]
}
