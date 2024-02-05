resource "azurerm_resource_group" "vmrg1" {
  for_each = var.rgname
  name     = each.value.name
  location = each.value.location
   tags = {
    "Created By" = "Shivam"
  }
}
