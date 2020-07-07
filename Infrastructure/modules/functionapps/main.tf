resource "azurerm_storage_account" "functionapptoollboothstorage" {
  name                     = var.function_storage_tollboothapp
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "functionapptoolbootheventsstorage" {
  name                     = var.function_storage_tollboothevents
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "consumptionplan1" {
  name                = var.app_service_plan1
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
resource "azurerm_app_service_plan" "consumptionplan2" {
  name                = var.app_service_plan2
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
resource "azurerm_function_app" "tollboothapp" {
    name                      = var.tollboothapp
    location                  = var.location
    resource_group_name       = var.resource_group_name
    app_service_plan_id       = azurerm_app_service_plan.consumptionplan1.id
    storage_account_name      = azurerm_storage_account.functionapptoollboothstorage.name
    //storage_connection_string = azurerm_storage_account.functionappstorage.primary_connection_string
    storage_account_access_key= azurerm_storage_account.functionapptoollboothstorage.primary_access_key
    version                   = "~3"
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME = "dotnet"
      computerVisionApiUrl = var.vision_endpoint
      computerVisionApiKey = "@Microsoft.KeyVault(SecretUri=${var.vault_uri}secrets/${var.vision_secret}/${var.vision_secret_version})"

      eventGridTopicEndpoint = var.topic_endpoint
      eventGridTopicKey = "@Microsoft.KeyVault(SecretUri=${var.vault_uri}secrets/${var.event_grid_secret}/${var.event_grid_secret_version})"

      cosmosDBEndPointUrl = var.cosmosdb_endpoint
      cosmosDBAuthorizationKey = "@Microsoft.KeyVault(SecretUri=${var.vault_uri}secrets/${var.cosmosdb_secret}/${var.cosmosdb_secret_version})"

      cosmosDBDatabaseId = var.sql_database
      cosmosDBCollectionId = var.sql_container_processed

      exportCsvContainerName = var.export_container
      blobStorageConnection = "@Microsoft.KeyVault(SecretUri=${var.vault_uri}secrets/${var.storage_secret}/${var.storage_secret_version})"
    }
    identity {
        type = "SystemAssigned"
    }
}

resource "azurerm_function_app" "tollboothevents" {
  name                      = var.toolboothevents
  location                  = var.location
  resource_group_name       = var.resource_group_name
  app_service_plan_id       = azurerm_app_service_plan.consumptionplan2.id
  storage_account_name      = azurerm_storage_account.functionapptoolbootheventsstorage.name
  storage_account_access_key= azurerm_storage_account.functionapptoolbootheventsstorage.primary_access_key
  version                   = "~3"
  app_settings = {
        FUNCTIONS_WORKER_RUNTIME = "node"
  }
}
