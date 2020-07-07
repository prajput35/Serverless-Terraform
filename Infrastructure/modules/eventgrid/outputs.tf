output topic_access_key {
  value = azurerm_eventgrid_topic.TollboothEventGrid.primary_access_key
}

output topic_endpoint {
  value = azurerm_eventgrid_topic.TollboothEventGrid.endpoint
}

output topic_id {
  value = azurerm_eventgrid_topic.TollboothEventGrid.id
}