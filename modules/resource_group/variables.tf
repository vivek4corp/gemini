variable "resource_groups" {
  description = "Map of resource groups to create. The key is the RG name."
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
}
