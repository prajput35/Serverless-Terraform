##################################
# Azure Resource Group variables #
##################################

variable resource_group_name {
  type        = string
  description = "The name of an existing Resource Group"
}

variable location {
  type        = string
  description = "Define the region the Azure Key Vault should be created, you should use the Resource Group location"
}

variable name {
  type        = string
  description = "The name of the Azure Key Vault"
  default     = "TollBoothVaultINITJE"
}

variable tollbooth_tenant_id {}

variable tollbooth_principal_id {}
variable vision_secret_name {
  default     = "computerVisionApiKey"
}
variable vision_primary_access_key {}

variable event_grid_secret_name {
  default     = "eventGridTopicKey"
}
variable topic_access_key {}

variable cosmosdb_secret_name {
  default     = "cosmosDBAuthorizationKey"
}
variable cosmosdb_primary_key {}

variable storage_secret_name {
  default     = "blobStorageConnection"
}
variable tollbooth_storage_connection {}

