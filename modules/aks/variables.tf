variable "clusters" {
  description = "Map of AKS clusters to create."
  type = map(object({
    resource_group_name = string
    location            = string
    dns_prefix          = string
    kubernetes_version  = optional(string)
    sku_tier            = optional(string, "Standard") # Paid SKU for SLA

    default_node_pool = object({
      name                         = string
      node_count                   = optional(number, 3)
      vm_size                      = optional(string, "Standard_DS2_v2")
      enable_auto_scaling          = optional(bool, true)
      min_count                    = optional(number, 3)
      max_count                    = optional(number, 10)
      type                         = optional(string, "VirtualMachineScaleSets")
      vnet_subnet_id               = optional(string)
      max_pods                     = optional(number, 50)
      os_disk_type                 = optional(string, "Ephemeral")
      enable_node_public_ip        = optional(bool, false)
      only_critical_addons_enabled = optional(bool, true)
    })

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }), { type = "SystemAssigned" })

    network_profile = optional(object({
      network_plugin     = optional(string, "azure")
      network_policy     = optional(string, "azure")
      dns_service_ip     = optional(string)
      docker_bridge_cidr = optional(string)
      service_cidr       = optional(string)
      load_balancer_sku  = optional(string, "standard")
    }), { network_plugin = "azure", network_policy = "azure" })

    role_based_access_control_enabled = optional(bool, true)
    azure_policy_enabled              = optional(bool, true)
    http_application_routing_enabled  = optional(bool, false)
    local_account_disabled            = optional(bool, true)
    private_cluster_enabled           = optional(bool, true)
    automatic_channel_upgrade         = optional(string, "stable")

    oms_agent = optional(object({
      log_analytics_workspace_id = string
    }))

    key_vault_secrets_provider = optional(object({
      secret_rotation_enabled = optional(bool, true)
    }), { secret_rotation_enabled = true })

    tags = optional(map(string), {})
  }))
}
