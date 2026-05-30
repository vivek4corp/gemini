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
    resource_group_key = "rg-myapp-dev-eastus"
    sku                = "Standard"
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
      name       = "default"
      node_count = 1
      vm_size    = "Standard_DS2_v2"
    }
    tags = {
      environment = "dev"
    }
  }
}
