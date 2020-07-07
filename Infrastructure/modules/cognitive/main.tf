resource "azurerm_cognitive_account" "computervision" {
  name                = var.vision
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.api_kind

  sku_name = "S1"

  tags = {
    Owner = "Paras Rajput"
  }
}