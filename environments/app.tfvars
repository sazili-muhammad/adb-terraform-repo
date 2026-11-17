environment    = "app"
project_name   = "personal"
location       = "australiaeast"
databricks_sku = "premium"

cluster_config = {
  spark_version           = "" # Leave blank to automatically use the latest LTS runtime
  node_type_id            = "Standard_D2ds_v5"
  driver_node_type_id     = "Standard_D2ds_v5"
  autotermination_minutes = 30
  min_workers             = 1
  max_workers             = 1
  spot_bid_max_price      = 0

  spark_conf = {
    "spark.sql.adaptive.enabled" = "true"
  }
}

tags = {
  CostCenter = "Data-Engineering-App"
}
