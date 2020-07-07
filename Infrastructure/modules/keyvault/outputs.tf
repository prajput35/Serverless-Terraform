output vault_uri {
  value       = azurerm_key_vault.kv.vault_uri
}

output vision_secret{
  value=azurerm_key_vault_secret.vision-secret.name
} 
output vision_secret_version{
  value=azurerm_key_vault_secret.vision-secret.version
}

output event_grid_secret{
  value=azurerm_key_vault_secret.event-grid-secret.name
} 
output event_grid_secret_version{
  value=azurerm_key_vault_secret.event-grid-secret.version
}

output cosmosdb_secret{
  value=azurerm_key_vault_secret.cosmosdb-secret.name
} 
output cosmosdb_secret_version{
  value=azurerm_key_vault_secret.cosmosdb-secret.version
}

output storage_secret{
  value=azurerm_key_vault_secret.storage-secret.name
} 
output storage_secret_version{
  value=azurerm_key_vault_secret.storage-secret.version
}