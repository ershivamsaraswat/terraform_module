module "resource_group" {
  source = "../../module/resourcegroup1"
  rgname = var.rgname

}
module "virtual_network" {
  source     = "../../module/vnet"
  vnet       = var.vnet
  depends_on = [module.resource_group]
}
module "subnetvm" {
  source     = "../../module/subnet"
  subnet     = var.subnet
  depends_on = [module.virtual_network]
}
module "network_interface" {
  source     = "../../module/NIC"
  nic        = var.nic
  depends_on = [module.subnetvm]
}
module "network_security_group" {
  source     = "../../module/NSG"
  nsg        = var.nsg
  rules      = var.rules
  depends_on = [module.resource_group]
}
module "nsgassociation" {
  source     = "../../module/NSG assocaiton"
  nsa        = var.nsa
  depends_on = [module.network_interface]
}
module "publicip" {
  source     = "../../module/public ip"
  pip        = var.pip
  depends_on = [module.resource_group]
}
module "sqlservervm" {
  source     = "../../module/sql server"
  sqlserver  = var.sqlserver
  depends_on = [module.resource_group]
}
module "sqldatabasevm" {
  source     = "../../module/sql database"
  sqldb      = var.sqldb
  depends_on = [module.sqlservervm]
}
module "linuxvm" {
  source     = "../../module/VM"
  vm         = var.vm
  depends_on = [module.network_interface]
}
module "bastionvm" {
  source     = "../../module/bastion"
  bastion    = var.bastion
  depends_on = [module.publicip,module.subnetvm]
}