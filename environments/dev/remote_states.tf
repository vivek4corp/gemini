data "terraform_remote_state" "rg" {
  backend = "azurerm"
  config = merge(local.backend_config, {
    key = "dev-rg.tfstate"
  })
}
