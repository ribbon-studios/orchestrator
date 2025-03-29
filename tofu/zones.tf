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

  ddns = "c2420122.eero.online"
}

module "cecilias_me" {
  source = "./modules/zone"
  domain = "cecilias.me"

  records = []
}

module "sanare_dev" {
  source = "./modules/zone"
  domain = "sanare.dev"

  records = [
    {
      name    = "_atproto"
      type    = "TXT"
      records = ["did=did:plc:v752poqqndkxxcpayq44s5n3"]
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
      name    = "fin"
      type    = "CNAME"
      records = [local.ddns]
    },
    {
      name    = "docs"
      type    = "CNAME"
      records = [local.ddns]
    },
    {
      name    = "cafe"
      type    = "CNAME"
      records = [local.ddns]
    },
    {
      name    = "mc"
      type    = "CNAME"
      records = [local.ddns]
    }
  ]
}

module "protontweaks_com" {
  source = "./modules/zone"
  domain = "protontweaks.com"

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
      name    = "api"
      type    = "CNAME"
      records = ["ribbon-studios.github.io"]
    },
  ]
}

module "ribbonstudios_com" {
  source = "./modules/zone"
  domain = "ribbonstudios.com"

  records = [
    {
      name    = "_atproto"
      type    = "TXT"
      records = ["did=did:plc:qdtgu5fzproijomwnoi2yjyb"]
    },
    {
      name = "_github-challenge-rain-cafe-org"
      type = "TXT"
      records = [
        "6cb6707451"
      ]
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
      name    = "zelda"
      type    = "CNAME"
      records = ["ribbon-studios.github.io"]
    },
    {
      name    = "utils"
      type    = "CNAME"
      records = ["rain-cafe-utils.netlify.app"]
    },
    {
      name    = "refreshly"
      type    = "CNAME"
      records = ["dfa3a8b5de-hosting.gitbook.io"]
    },
    {
      name    = "flarie"
      type    = "CNAME"
      records = ["dfa3a8b5de-hosting.gitbook.io"]
    },
    {
      name    = "devkit"
      type    = "CNAME"
      records = ["ribbon-studios.github.io"]
    },
    {
      name    = "tyria"
      type    = "CNAME"
      records = ["ribbon-studios.github.io"]
    }
  ]
}

output "name_servers" {
  value = {
    "cecilias.me"       = module.cecilias_me.name_servers
    "sanare.dev"        = module.sanare_dev.name_servers
    "protontweaks.com"  = module.protontweaks_com.name_servers
    "ribbonstudios.com" = module.ribbonstudios_com.name_servers
  }
}
