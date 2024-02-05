data "azurerm_resource_group" "datarg" {
  name = "vmrg"
}
data "azurerm_virtual_network" "datavnet" {
    for_each = var.peering
  name                = each.value.virtualnetworkname2
  resource_group_name = data.azurerm_resource_group.datarg.name
}
