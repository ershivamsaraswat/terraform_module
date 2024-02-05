data "azurerm_resource_group" "datarg" {
  name = "vmrg"
}
data "azurerm_virtual_network" "datavnet" {
  name                = "vnetvm"
  resource_group_name = data.azurerm_resource_group.datarg.name
}
data "azurerm_subnet" "datasub" {
  for_each             = var.nsa
  name                 = each.value.subnet_name
  virtual_network_name = data.azurerm_virtual_network.datavnet.name
  resource_group_name  = data.azurerm_resource_group.datarg.name
}
data "azurerm_network_security_group" "datansg" {
  for_each            = var.nsa
  name                = each.value.network_security_group_name
  resource_group_name = data.azurerm_resource_group.datarg.name

}