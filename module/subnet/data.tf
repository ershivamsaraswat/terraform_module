data "azurerm_resource_group" "datarg" {
  name = "vmrg"
}
data "azurerm_virtual_network" "datavnet" {
  name                = "vnetvm"
  resource_group_name = data.azurerm_resource_group.datarg.name
}
