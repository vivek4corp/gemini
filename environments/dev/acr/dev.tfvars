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
