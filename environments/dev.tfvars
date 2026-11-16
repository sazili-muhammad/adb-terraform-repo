environment    = "dev"
project_name   = "dataplatform"
location       = "southeastasia"
databricks_sku = "premium"

cluster_config = {
  spark_version           = "" # Leave blank to automatically use the latest LTS runtime
  node_type_id            = "Standard_DS3_v2"
  driver_node_type_id     = "Standard_DS3_v2"
  autotermination_minutes = 20
  min_workers             = 1
  max_workers             = 3
  spot_bid_max_price      = -1

  spark_conf = {
    "spark.sql.adaptive.enabled" = "true"
  }
}

tags = {
  CostCenter = "Engineering-Dev"
}
