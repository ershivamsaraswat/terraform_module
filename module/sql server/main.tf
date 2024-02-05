resource "azurerm_sql_server" "sqlserver1" {
  for_each                     = var.sqlserver
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "shivam18267"
  administrator_login_password = "ril@2024"
}