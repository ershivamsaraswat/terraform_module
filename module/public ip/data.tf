data "azurerm_resource_group" "datarg" {
  name = "vmrg"
}
data "azurerm_location" "datal" {
  location = "Central India"
}