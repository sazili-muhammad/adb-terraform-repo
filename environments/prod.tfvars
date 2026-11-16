environment    = "prod"
project_name   = "dataplatform"
location       = "southeastasia"
databricks_sku = "premium"

cluster_config = {
  spark_version           = "" # Pin to a specific string like "15.4.x-scala2.12" for strict prod stability
  node_type_id            = "Standard_DS4_v2"
  driver_node_type_id     = "Standard_DS4_v2"
  autotermination_minutes = 60
  min_workers             = 2
  max_workers             = 8
  spot_bid_max_price      = 0 # 0 forces 100% On-Demand VMs

  spark_conf = {
    "spark.sql.adaptive.enabled" = "true"
  }
}

tags = {
  CostCenter = "Production-Analytics"
}
