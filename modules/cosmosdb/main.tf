
resource "azurerm_cosmosdb_account" "db" {
  name                = var.cosmosdb
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "Session"
  }

  #geo_location {
  #  location          = var.failover_location
  #  failover_priority = 1
  #}

  geo_location {
    #prefix            = "${var.cosmosdb}-${random_integer.ri.result}-customid"
    location          = var.location
    failover_priority = 0
  }
  ip_range_filter="172.17.59.65"
}

resource "azurerm_cosmosdb_sql_database" "sqldb" {
  name                = var.sql_database
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  #throughput          = 400
}

resource "azurerm_cosmosdb_sql_container" "processed_container" {
  name                = var.sql_container_processed
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path  = var.c1_partitionkey
  throughput          = 5000

  #unique_key {
  #  paths = ["/definition/idlong", "/definition/idshort"]
  #}
}

resource "azurerm_cosmosdb_sql_container" "review_container" {
  name                = var.sql_container_NeedsManualReview
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path  = var.c2_partitionkey
  throughput          = 5000

}
