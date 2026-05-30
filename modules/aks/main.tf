resource "azurerm_kubernetes_cluster" "this" {
  for_each = var.clusters

  name                              = each.key
  location                          = each.value.location
  resource_group_name               = each.value.resource_group_name
  dns_prefix                        = each.value.dns_prefix
  kubernetes_version                = each.value.kubernetes_version
  sku_tier                          = each.value.sku_tier
  role_based_access_control_enabled = each.value.role_based_access_control_enabled
  azure_policy_enabled              = each.value.azure_policy_enabled
  http_application_routing_enabled  = each.value.http_application_routing_enabled
  local_account_disabled            = each.value.local_account_disabled
  private_cluster_enabled           = each.value.private_cluster_enabled
  automatic_channel_upgrade         = each.value.automatic_channel_upgrade

  default_node_pool {
    name                         = each.value.default_node_pool.name
    node_count                   = each.value.default_node_pool.node_count
    vm_size                      = each.value.default_node_pool.vm_size
    enable_auto_scaling          = each.value.default_node_pool.enable_auto_scaling
    min_count                    = each.value.default_node_pool.min_count
    max_count                    = each.value.default_node_pool.max_count
    type                         = each.value.default_node_pool.type
    vnet_subnet_id               = each.value.default_node_pool.vnet_subnet_id
    max_pods                     = each.value.default_node_pool.max_pods
    os_disk_type                 = each.value.default_node_pool.os_disk_type
    enable_node_public_ip        = each.value.default_node_pool.enable_node_public_ip
    only_critical_addons_enabled = each.value.default_node_pool.only_critical_addons_enabled
  }

  identity {
    type         = each.value.identity.type
    identity_ids = each.value.identity.identity_ids
  }

  network_profile {
    network_plugin     = each.value.network_profile.network_plugin
    network_policy     = each.value.network_profile.network_policy
    dns_service_ip     = each.value.network_profile.dns_service_ip
    docker_bridge_cidr = each.value.network_profile.docker_bridge_cidr
    service_cidr       = each.value.network_profile.service_cidr
    load_balancer_sku  = each.value.network_profile.load_balancer_sku
  }

  dynamic "oms_agent" {
    for_each = each.value.oms_agent != null ? [each.value.oms_agent] : []
    content {
      log_analytics_workspace_id = oms_agent.value.log_analytics_workspace_id
    }
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = each.value.key_vault_secrets_provider.secret_rotation_enabled
  }

  tags = each.value.tags
}
