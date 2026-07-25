variable "nics" {}



data "azurerm_subnet" "subnet1" {
  for_each             = var.nics
  name                 = each.value.nic_subnet_name
  virtual_network_name = each.value.nic_vnet_name
  resource_group_name  = each.value.nic_rg

}

data "azurerm_public_ip" "pip1" {
  for_each = var.nics

  name                = each.value.nic_pip_name
  resource_group_name = each.value.nic_rg

}

resource "azurerm_network_interface" "main" {
  for_each            = var.nics
  name                = each.value.nic_name
  location            = each.value.nic_location
  resource_group_name = each.value.nic_rg

  ip_configuration {
    name                          = "paglwa"
    subnet_id                     = data.azurerm_subnet.subnet1[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.pip1[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}


