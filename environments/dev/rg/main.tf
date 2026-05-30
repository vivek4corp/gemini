terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "NetworkWatcherRG"
    storage_account_name = "testinggemini"
    container_name       = "tfstate"
    key                  = "dev-rg.tfstate"
  }
}

provider "azurerm" {
  features {}
}

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
