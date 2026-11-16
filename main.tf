locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform Databricks Module"
    },
    var.tags
  )
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_databricks_workspace" "this" {
  name                        = "adb-${local.name_prefix}"
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  sku                         = var.databricks_sku
  managed_resource_group_name = "rg-${local.name_prefix}-adb-managed"
  tags                        = local.common_tags
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on        = [azurerm_databricks_workspace.this]
}

resource "databricks_cluster" "this" {
  cluster_name            = "cluster-${local.name_prefix}-shared"
  spark_version           = var.cluster_config.spark_version != "" ? var.cluster_config.spark_version : data.databricks_spark_version.latest_lts.id
  node_type_id            = var.cluster_config.node_type_id
  driver_node_type_id     = var.cluster_config.driver_node_type_id
  autotermination_minutes = var.cluster_config.autotermination_minutes
  data_security_mode      = "USER_ISOLATION"

  autoscale {
    min_workers = var.cluster_config.min_workers
    max_workers = var.cluster_config.max_workers
  }

  azure_attributes {
    availability       = var.cluster_config.spot_bid_max_price != 0 ? "SPOT_WITH_FALLBACK_AZURE" : "ON_DEMAND_AZURE"
    first_on_demand    = 1
    spot_bid_max_price = var.cluster_config.spot_bid_max_price
  }

  spark_conf = merge(
    {
      #"spark.databricks.cluster.profile" = "serverless"
      "spark.databricks.io.cache.enabled" : "true"
    },
    var.cluster_config.spark_conf
  )

  custom_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
