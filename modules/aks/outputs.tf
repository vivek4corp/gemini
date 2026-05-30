output "clusters" {
  description = "Map of AKS cluster objects created."
  value       = azurerm_kubernetes_cluster.this
}

output "kube_configs" {
  description = "Map of raw kube_config for each cluster."
  value       = { for k, v in azurerm_kubernetes_cluster.this : k => v.kube_config_raw }
  sensitive   = true
}
