resource "azurerm_bastion_host" "bastiontest" {
  for_each            = var.bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"
  ip_configuration {
    name                 = "vnetvm-ip"
    subnet_id            = data.azurerm_subnet.datasub.id
    public_ip_address_id = data.azurerm_public_ip.datapip.id
  }
}


