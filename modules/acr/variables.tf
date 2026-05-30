variable "registries" {
  description = "Map of Container Registries to create."
  type = map(object({
    resource_group_name = string
    location            = string
    sku                 = optional(string, "Standard")
    admin_enabled       = optional(bool, false)
    public_network_access_enabled = optional(bool, true)
    quarantine_policy_enabled     = optional(bool, false)
    zone_redundancy_enabled       = optional(bool, false)
    tags                          = optional(map(string), {})
    georeplications = optional(list(object({
      location                  = string
      regional_endpoint_enabled = optional(bool, true)
      zone_redundancy_enabled   = optional(bool, false)
      tags                      = optional(map(string), {})
    })), [])
  }))
}
