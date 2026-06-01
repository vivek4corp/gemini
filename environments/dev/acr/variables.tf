variable "registries" {
  description = "Map of ACRs to create."
  type = map(object({
    resource_group_key            = string
    sku                           = optional(string, "Premium")
    admin_enabled                 = optional(bool, false)
    public_network_access_enabled = optional(bool, false)
    tags                          = optional(map(string), {})
  }))
  default = {}
}
