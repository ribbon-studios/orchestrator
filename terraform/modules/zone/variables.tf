variable "domain" {
  type        = string
  description = "The zone base domain"
}

variable "records" {
  type = list(object({
    name    = optional(string, ""),
    type    = string,
    ttl     = optional(number, 300),
    records = list(string)
  }))
  description = "The records for the domain"

  validation {
    condition = alltrue([
      for o in var.records : contains(["A", "AAAA", "CAA", "CNAME", "DS", "MX", "NAPTR", "NS", "PTR", "SOA", "SPF", "SRV", "TXT"], o.type)
    ])
    error_message = "Record Type must be 'A', 'AAAA', 'CAA', 'CNAME', 'DS', 'MX', 'NAPTR', 'NS', 'PTR', 'SOA', 'SPF', 'SRV', or 'TXT'."
  } 
}
