resource "azurerm_virtual_network_peering" "peering" {
    for_each = var.peering
  name                      = each.value.name
  resource_group_name       = data.azurerm_resource_group.datarg.name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = data.azurerm_virtual_network.datavnet[each.key].id
}