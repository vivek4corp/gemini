resource_groups = {
  "rg-myapp-dev-eastus" = {
    location = "eastus"
    tags = {
      environment = "dev"
      project     = "myapp"
    }
  }
}

registries = {
  "acrmyappdeveastus" = {
    resource_group_key            = "rg-myapp-dev-eastus"
    sku                           = "Premium"
    public_network_access_enabled = false
    tags = {
      environment = "dev"
    }
  }
}

clusters = {
  "aks-myapp-dev-eastus" = {
    resource_group_key = "rg-myapp-dev-eastus"
    dns_prefix         = "aksmyappdev"
    default_node_pool = {
      name                = "system"
      node_count          = 3
      vm_size             = "Standard_DS2_v2"
      enable_auto_scaling = true
      min_count           = 3
      max_count           = 10
    }
    tags = {
      environment = "dev"
    }
  }
}
