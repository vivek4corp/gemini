module "resource_groups" {
  source = "../../../modules/resource_group"

  resource_groups = var.resource_groups
}

output "names" {
  value = module.resource_groups.names
}

output "locations" {
  value = module.resource_groups.locations
}
