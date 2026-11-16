output "resource_group_name" {
  description = "Name of the created Azure Resource Group"
  value       = azurerm_resource_group.this.name
}

output "databricks_workspace_id" {
  description = "Azure Resource ID of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.id
}

output "databricks_workspace_url" {
  description = "URL to access the Azure Databricks workspace UI"
  value       = "https://${azurerm_databricks_workspace.this.workspace_url}"
}

output "databricks_cluster_id" {
  description = "ID of the provisioned Databricks compute cluster"
  value       = databricks_cluster.this.id
}

output "resolved_spark_version" {
  description = "Spark runtime version assigned to the cluster"
  value       = databricks_cluster.this.spark_version
}
