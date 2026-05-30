variable "registries" {
  description = "Map of Container Registries to create."
  type = map(object({
    resource_group_name           = string
    location                      = string
    sku                           = optional(string, "Premium")
    admin_enabled                 = optional(bool, false)
    public_network_access_enabled = optional(bool, false)
    quarantine_policy_enabled     = optional(bool, true)
    zone_redundancy_enabled       = optional(bool, true)
    data_endpoint_enabled         = optional(bool, true)
    anonymous_pull_enabled        = optional(bool, false)
    network_rule_bypass_option    = optional(string, "AzureServices")
    tags                          = optional(map(string), {})
    georeplications = optional(list(object({
      location                  = string
      regional_endpoint_enabled = optional(bool, true)
      zone_redundancy_enabled   = optional(bool, true)
      tags                      = optional(map(string), {})
    })), [])
    retention_policy = optional(object({
      days    = optional(number, 7)
      enabled = optional(bool, true)
    }), { days = 7, enabled = true })
    trust_policy = optional(object({
      enabled = optional(bool, true)
    }), { enabled = true })
  }))
}
