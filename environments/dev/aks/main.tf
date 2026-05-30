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
    key                  = "dev-aks.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "rg" {
  backend = "azurerm"
  config = {
    resource_group_name  = "NetworkWatcherRG"
    storage_account_name = "testinggemini"
    container_name       = "tfstate"
    key                  = "dev-rg.tfstate"
  }
}

module "clusters" {
  source = "../../../modules/aks"

  clusters = {
    for k, v in var.clusters : k => merge(v, {
      resource_group_name = data.terraform_remote_state.rg.outputs.names[v.resource_group_key]
      location            = data.terraform_remote_state.rg.outputs.locations[v.resource_group_key]
    })
  }
}
