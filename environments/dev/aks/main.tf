module "clusters" {
  source = "../../../modules/aks"

  clusters = {
    for k, v in var.clusters : k => merge(v, {
      resource_group_name = data.terraform_remote_state.rg.outputs.names[v.resource_group_key]
      location            = data.terraform_remote_state.rg.outputs.locations[v.resource_group_key]
    })
  }
}
