
resource "azurerm_eventgrid_topic" "TollboothEventGrid" {
  name                = var.TollboothEventGrid
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    owner = "Paras Rajput"
  }
}