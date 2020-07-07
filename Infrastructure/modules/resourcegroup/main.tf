resource "azurerm_resource_group" "group"{
    name = "ServerlessArchitecture"
    location="japaneast"

    tags={
        owner="Paras Rajput"
    }
}

