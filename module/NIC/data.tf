data "azurerm_resource_group" "datarg" {
  name = "vmrg"
}
data "azurerm_location" "datal" {
  location = "Central India"
}
data "azurerm_virtual_network" "datavnet" {
  name                = "vnetvm"
  resource_group_name = data.azurerm_resource_group.datarg.name
}
data "azurerm_subnet" "datasub" {
  for_each             = var.nic
  name                 = each.value.subnet_name
  virtual_network_name = data.azurerm_virtual_network.datavnet.name
  resource_group_name  = data.azurerm_resource_group.datarg.name
}
