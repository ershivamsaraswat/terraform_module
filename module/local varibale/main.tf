locals {
  rg_prefixes ="shivam"
  tags ={
    managed_by = "terraform"
  }
}




resource "azurerm_resource_group" "example" {
    for_each = var.rgname
  name     = "${local.rg_prefixes}${each.value.name}"
  location = "${each.value.location}"
  tags = local.tags
}