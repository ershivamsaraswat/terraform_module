resource "azurerm_linux_virtual_machine" "vms" {
  for_each                        = var.vm
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = "Standard_DS1_v2"
  admin_username                  = "shivam18267"
  admin_password                  = "ril@2024"
  disable_password_authentication = false
  network_interface_ids           = [data.azurerm_network_interface.datnic[each.key].id]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}