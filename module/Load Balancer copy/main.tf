resource "azurerm_lb" "lb" {
  name                = "vmlb"
  location            = "Central India"
  resource_group_name = "vmrg"
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "/subscriptions/f1a19598-cdb9-4d52-abd0-40ab33a99390/resourceGroups/vmrg/providers/Microsoft.Network/publicIPAddresses/pipvm1"
  }
}
resource "azurerm_lb_backend_address_pool" "backpool" {
  loadbalancer_id = resource.azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}
resource "azurerm_network_interface_backend_address_pool_association" "bpa" {
  network_interface_id    = "/subscriptions/f1a19598-cdb9-4d52-abd0-40ab33a99390/resourceGroups/vmrg/providers/Microsoft.Network/networkInterfaces/nicvm1"
  ip_configuration_name   = "internal"
  backend_address_pool_id = resource.azurerm_lb_backend_address_pool.backpool.id
}
resource "azurerm_network_interface_backend_address_pool_association" "bpa2" {
  network_interface_id    = "/subscriptions/f1a19598-cdb9-4d52-abd0-40ab33a99390/resourceGroups/vmrg/providers/Microsoft.Network/networkInterfaces/nicvm3"
  ip_configuration_name   = "internal"
  backend_address_pool_id = resource.azurerm_lb_backend_address_pool.backpool.id
}
resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = resource.azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backpool.id]
  probe_id = azurerm_lb_probe.lb_health_probe.id
}
resource "azurerm_lb_probe" "lb_health_probe" {
  name                = "frontend_probe"
  loadbalancer_id     = resource.azurerm_lb.lb.id
  port                = 80     # specify the port to probe

  interval_in_seconds  = 5    # probe every 15 seconds
}