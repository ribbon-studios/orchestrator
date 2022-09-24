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
      type    = "A"
      records = local.github_pages_ipv4
    },
    {
      type    = "AAAA"
      records = local.github_pages_ipv6
    },
    {
      name    = "www"
      type    = "CNAME"
      records = ["rain-cafe.github.io"]
    },
    {
      name    = "silvy"
      type    = "CNAME"
      records = ["cname.vercel-dns.com"]
    }
  ]
}
