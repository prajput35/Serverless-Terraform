resource "azurerm_storage_account" "serverlessstorage" {
  name                     = var.storageaccount
  resource_group_name      = var.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "imagecontainer" {
  name                  = var.image_container
  storage_account_name  = azurerm_storage_account.serverlessstorage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "exportcontainer" {
  name                  = var.export_container
  storage_account_name  = azurerm_storage_account.serverlessstorage.name
  container_access_type = "private"
}