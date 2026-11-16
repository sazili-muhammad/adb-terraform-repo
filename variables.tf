variable "environment" {
  description = "Target deployment environment (dev or prod)"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "project_name" {
  description = "Base project prefix used for resource naming"
  type        = string
  default     = "dataplatform"
}

variable "location" {
  description = "Azure region for the resource group and workspace"
  type        = string
  default     = "southeastasia"
}

variable "databricks_sku" {
  description = "Azure Databricks pricing tier (standard, premium, or trial)"
  type        = string
  default     = "premium"
}

variable "cluster_config" {
  description = "Dynamic configuration parameters for the Databricks cluster"
  type = object({
    spark_version           = optional(string, "")
    node_type_id            = string
    driver_node_type_id     = string
    autotermination_minutes = number
    min_workers             = number
    max_workers             = number
    spot_bid_max_price      = number
    spark_conf              = optional(map(string), {})
  })
}

variable "tags" {
  description = "Additional tags applied to Azure resources"
  type        = map(string)
  default     = {}
}
