resource "azurerm_resource_group" "rg" {
  name     = "vmrg"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
    count = var.storage ? 1:0
  name                     = "storagecount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}