
output app_tenant_id {
  value       = azurerm_function_app.tollboothapp.identity[0].tenant_id
}

output app_principal_id {
  value       = azurerm_function_app.tollboothapp.identity[0].principal_id
}

