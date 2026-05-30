output "resource_groups" {
  description = "Map of resource group objects created."
  value       = azurerm_resource_group.this
}

output "names" {
  description = "Map of resource group names."
  value       = { for k, v in azurerm_resource_group.this : k => v.name }
}

output "locations" {
  description = "Map of resource group locations."
  value       = { for k, v in azurerm_resource_group.this : k => v.location }
}
