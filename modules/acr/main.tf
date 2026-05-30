resource "azurerm_container_registry" "this" {
  for_each = var.registries

  name                          = each.key
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  sku                           = each.value.sku
  admin_enabled                 = each.value.admin_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  quarantine_policy_enabled     = each.value.quarantine_policy_enabled
  zone_redundancy_enabled       = each.value.zone_redundancy_enabled
  data_endpoint_enabled         = each.value.data_endpoint_enabled
  anonymous_pull_enabled        = each.value.anonymous_pull_enabled
  network_rule_bypass_option    = each.value.network_rule_bypass_option
  tags                          = each.value.tags

  dynamic "georeplications" {
    for_each = each.value.georeplications
    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = georeplications.value.regional_endpoint_enabled
      zone_redundancy_enabled   = georeplications.value.zone_redundancy_enabled
      tags                      = georeplications.value.tags
    }
  }

  retention_policy {
    days    = each.value.retention_policy.days
    enabled = each.value.retention_policy.enabled
  }

  trust_policy {
    enabled = each.value.trust_policy.enabled
  }
}
