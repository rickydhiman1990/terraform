variable "vims" {}

data "azurerm_network_interface" "nic" {
  for_each            = var.vims
  name                = each.value.vm_nicname
#   location            = each.value.vm_location
  resource_group_name = each.value.vm_resource_group_name

}

resource "azurerm_virtual_machine" "main" {
  for_each              = var.vims
  location              = each.value.vm_location
  name                  = each.value.vm_name
  resource_group_name   = each.value.vm_resource_group_name
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id]
  vm_size               = each.value.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {

    publisher = each.value.vm_publisher
    offer     = each.value.vm_offer
    sku       = each.value.vm_sku
    version   = each.value.vm_version
  }
  storage_os_disk {
    name              = each.value.s_name
    caching           = each.value.s_caching
    create_option     = each.value.s_create_option
    managed_disk_type = each.value.s_managed_disk_type
  }
  os_profile {
    computer_name  = each.value.o_computer_name
    admin_username = each.value.o_admin_username
    admin_password = each.value.o_admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}