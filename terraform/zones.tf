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
  google = "pFsrSZl3l9vbQScTjdtXieVHE1Ce8pkMkZRagaVlzxA"

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
      name    = "github"
      type    = "CNAME"
      records = ["https://github.com/cecilia-sanare"]
    },
  ]
}

module "rains_cafe" {
  source = "./modules/zone"
  domain = "rains.cafe"
  google = "8n2S6aE0zRfPbVTwhknvMfENZH28tVnlLB60SlxFXwY"

  records = [
    {
      name = "_github-challenge-rain-cafe-org"
      type = "TXT"
      records = [
        "943ed230f8"
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
      name    = "www"
      type    = "CNAME"
      records = ["rain-cafe.github.io"]
    },
    {
      name    = "zelda"
      type    = "A"
      records = local.github_pages_ipv4
    },
    {
      name    = "zelda"
      type    = "AAAA"
      records = local.github_pages_ipv6
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
    },
    {
      name    = "flarie"
      type    = "CNAME"
      records = ["dfa3a8b5de-hosting.gitbook.io"]
    }
  ]
}

module "devkit_lgbt" {
  source = "./modules/zone"
  domain = "devkit.lgbt"
  google = "hhjM8G0PQBxkse8KHJkvmP8H9N5YrGJr31G8tYbfa_c"
}

module "charcoal_gg" {
  source = "./modules/zone"
  domain = "charcoal.gg"
  google = "bVauXlt-AWWHjES1jiZqqdubCwmV6p10aFlbJXDtkMA"
}

output "name_servers" {
  value = {
    "cecilias.me" = module.cecilias_me.name_servers
    "rains.cafe"  = module.rains_cafe.name_servers
    "devkit.lgbt" = module.devkit_lgbt.name_servers
  }
}
