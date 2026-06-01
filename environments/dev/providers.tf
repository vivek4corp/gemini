terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
  backend_config = {
    resource_group_name  = "NetworkWatcherRG"
    storage_account_name = "testinggemini"
    container_name       = "tfstate"
  }
}
