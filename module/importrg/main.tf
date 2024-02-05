resource "azurerm_resource_group" "example" {
  location = "eastus"
    name     = "shivamportal"
    tags     = {}
}






#terraform import azurerm_resource_group.example /subscriptions/21578d08-43ea-4ac5-9165-9c8d79f28820/resourceGroups/shivamportal
