data "azurerm_client_config" "sub" {}
resource "azurerm_key_vault" "example" {
  name                        = "shivam18267"
  location                    = "Central India"
  resource_group_name         = "vmrg"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.sub.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}