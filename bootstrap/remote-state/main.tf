provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state" {
  name     = "selise-demo-tfstate-rg"
  location = "eastus"
}

resource "azurerm_storage_account" "state" {
  name                     = "selisedemotfstate"
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    environment = "management"
    project     = "selise-demo"
  }
}

resource "azurerm_storage_container" "state" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
}
