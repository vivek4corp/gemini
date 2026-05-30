terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_groups" {
  source = "../../modules/resource_group"

  resource_groups = var.resource_groups
}

module "registries" {
  source = "../../modules/acr"

  registries = {
    for k, v in var.registries : k => merge(v, {
      resource_group_name = module.resource_groups.names[v.resource_group_key]
      location            = module.resource_groups.locations[v.resource_group_key]
    })
  }
}

module "clusters" {
  source = "../../modules/aks"

  clusters = {
    for k, v in var.clusters : k => merge(v, {
      resource_group_name = module.resource_groups.names[v.resource_group_key]
      location            = module.resource_groups.locations[v.resource_group_key]
    })
  }
}
