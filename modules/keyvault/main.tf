data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
    name                = var.name
    location            = var.location
    resource_group_name = var.resource_group_name

    sku_name = "standard"

    tenant_id = data.azurerm_client_config.current.tenant_id

    enabled_for_disk_encryption = true
    soft_delete_enabled         = true
    purge_protection_enabled    = false
    tags = {
        environment = "Development"
    }
}

resource "azurerm_key_vault_access_policy" "kv-access-policy_current" {
    key_vault_id = azurerm_key_vault.kv.id

    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

        lifecycle {
        create_before_destroy = true
    }

    secret_permissions = [
        "get","set","delete","list"
    ]
}


resource "azurerm_key_vault_access_policy" "kv-access-policy" {
    key_vault_id = azurerm_key_vault.kv.id

    tenant_id = var.tollbooth_tenant_id
    object_id = var.tollbooth_principal_id

        lifecycle {
        create_before_destroy = true
    }

    secret_permissions = [
        "get",
    ]
}

resource "azurerm_key_vault_secret" "vision-secret" {
  name         = var.vision_secret_name
  value        = var.vision_primary_access_key
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "event-grid-secret" {
  name         = var.event_grid_secret_name
  value        = var.topic_access_key
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "cosmosdb-secret" {
  name         = var.cosmosdb_secret_name
  value        = var.cosmosdb_primary_key
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "storage-secret" {
  name         = var.storage_secret_name
  value        = var.tollbooth_storage_connection
  key_vault_id = azurerm_key_vault.kv.id
}