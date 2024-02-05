resource "azurerm_subnet_network_security_group_association" "nsgasso" {
  for_each                  = var.nsa
  subnet_id                 = data.azurerm_subnet.datasub[each.key].id
  network_security_group_id = data.azurerm_network_security_group.datansg[each.key].id
}