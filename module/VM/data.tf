data "azurerm_resource_group" "datarg" {
  name = "vmrg"
}
data "azurerm_network_interface" "datnic" {
  for_each            = var.vm
  name                = each.value.network_interface_name
  resource_group_name = data.azurerm_resource_group.datarg.name
}
