output tollbooth_storage_connection {
  value       = azurerm_storage_account.serverlessstorage.primary_connection_string
}

output export_container {
  value     = var.export_container
}
