variable "clusters" {
  description = "Map of AKS clusters to create."
  type = map(object({
    resource_group_key = string
    dns_prefix         = string
    kubernetes_version = optional(string)
    default_node_pool = object({
      name                = string
      node_count          = optional(number, 3)
      vm_size             = optional(string, "Standard_DS2_v2")
      enable_auto_scaling = optional(bool, true)
      min_count           = optional(number, 3)
      max_count           = optional(number, 10)
    })
    tags = optional(map(string), {})
  }))
  default = {}
}
