data "azurerm_resource_group" "datarg" {
  name = "vmrg"
}
data "azurerm_virtual_network" "datavnet" {
  name                = "vnetvm"
  resource_group_name = data.azurerm_resource_group.datarg.name
}
data "azurerm_subnet" "datasub" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = data.azurerm_virtual_network.datavnet.name
  resource_group_name  = data.azurerm_resource_group.datarg.name
}
data "azurerm_public_ip" "datapip" {
  name                = "pipvm3"
  resource_group_name = data.azurerm_resource_group.datarg.name
}