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

  default_node_pool {
    name                = each.value.default_node_pool.name
    node_count          = each.value.default_node_pool.node_count
    vm_size             = each.value.default_node_pool.vm_size
    enable_auto_scaling = each.value.default_node_pool.enable_auto_scaling
    min_count           = each.value.default_node_pool.min_count
    max_count           = each.value.default_node_pool.max_count
    type                = each.value.default_node_pool.type
    vnet_subnet_id      = each.value.default_node_pool.vnet_subnet_id
    max_pods            = each.value.default_node_pool.max_pods
  }

  identity {
    type         = each.value.identity.type
    identity_ids = each.value.identity.identity_ids
  }

  dynamic "network_profile" {
    for_each = each.value.network_profile != null ? [each.value.network_profile] : []
    content {
      network_plugin     = network_profile.value.network_plugin
      network_policy     = network_profile.value.network_policy
      dns_service_ip     = network_profile.value.dns_service_ip
      docker_bridge_cidr = network_profile.value.docker_bridge_cidr
      service_cidr       = network_profile.value.service_cidr
      load_balancer_sku  = network_profile.value.load_balancer_sku
    }
  }

  tags = each.value.tags
}
