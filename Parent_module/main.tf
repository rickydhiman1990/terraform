module "resource_group" {
  source = "../child_module/Azurerm_resource_group"
  rgs    = var.rg
}



module "azurerm_virtual_network" {
  depends_on = [module.resource_group]
  source     = "../child_module/Azurerm_vnet"
  vnets      = var.vnet

}


module "sunet" {
  depends_on = [module.azurerm_virtual_network]
  source     = "../child_module/Azurerm_subnet"
  subnets    = var.subnet

}


module "nic" {
  depends_on = [module.sunet]
  source     = "../child_module/Azurerm_NIC"
  nics       = var.nic

}


module "pip" {
  depends_on = [module.resource_group]
  source     = "../child_module/Azurerm_pip"
  pips       = var.pip

}

module "azurerm_virtual_machine" {
  depends_on = [module.nic]
  source     = "../child_module/Azurerm_virtual_machine"
  vims       = var.vm

}