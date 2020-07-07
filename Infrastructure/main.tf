terraform {
  backend "azurerm" {
    resource_group_name  = "AZ204-300"
    storage_account_name = "az204300sa"
    container_name       = "serverless"
    key                  = "terraform.tfstate"

  }
}
#provider
provider "azurerm"{
    features {}
}

module resourcegroup{
    source="./modules/resourcegroup"
}

module storage{
    name=module.resourcegroup.resourcegp
    location=module.resourcegroup.rglocation
    source="./modules/storage"
}

module functionapps{
    vault_uri = module.keyvault.vault_uri
    vision_endpoint=module.cognitive.vision_endpoint
    vision_secret=module.keyvault.vision_secret
    vision_secret_version=module.keyvault.vision_secret_version
    
    topic_endpoint=module.eventgrid.topic_endpoint
    event_grid_secret=module.keyvault.event_grid_secret
    event_grid_secret_version=module.keyvault.event_grid_secret_version
    
    cosmosdb_endpoint=module.cosmosdb.cosmosdb_endpoint
    cosmosdb_secret=module.keyvault.cosmosdb_secret
    cosmosdb_secret_version=module.keyvault.cosmosdb_secret_version
    
    sql_database=module.cosmosdb.sql_database
    sql_container_processed=module.cosmosdb.sql_container_processed
    
    export_container=module.storage.export_container
    storage_secret=module.keyvault.storage_secret
    storage_secret_version=module.keyvault.storage_secret_version
    
    resource_group_name=module.resourcegroup.resourcegp
    location=module.resourcegroup.rglocation
    source="./modules/functionapps"
}

module eventgrid{
    resource_group_name=module.resourcegroup.resourcegp
    location=module.resourcegroup.rglocation
    source="./modules/eventgrid"
}

module cosmosdb{
    resource_group_name=module.resourcegroup.resourcegp
    location=module.resourcegroup.rglocation
    source="./modules/cosmosdb"
}

module cognitive{
    resource_group_name=module.resourcegroup.resourcegp
    location=module.resourcegroup.rglocation
    source="./modules/cognitive"
}


module keyvault{
    tollbooth_tenant_id=module.functionapps.app_tenant_id
    tollbooth_principal_id=module.functionapps.app_principal_id

    resource_group_name=module.resourcegroup.resourcegp
    location=module.resourcegroup.rglocation
    
    vision_primary_access_key=module.cognitive.vision_primary_access_key
    topic_access_key=module.eventgrid.topic_access_key
    cosmosdb_primary_key=module.cosmosdb.cosmosdb_primary_key
    tollbooth_storage_connection=module.storage.tollbooth_storage_connection
    source="./modules/keyvault"
}