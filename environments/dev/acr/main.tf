module "registries" {
  source = "../../../modules/acr"

  registries = {
    for k, v in var.registries : k => merge(v, {
      resource_group_name = data.terraform_remote_state.rg.outputs.names[v.resource_group_key]
      location            = data.terraform_remote_state.rg.outputs.locations[v.resource_group_key]
    })
  }
}
