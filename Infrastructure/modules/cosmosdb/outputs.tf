output cosmosdb_endpoint {
  value       = azurerm_cosmosdb_account.db.endpoint
}

output cosmosdb_primary_key {
  value       = azurerm_cosmosdb_account.db.primary_master_key
}

output sql_database{
  value = var.sql_database
}

output sql_container_processed{
  value = var.sql_container_processed
}

