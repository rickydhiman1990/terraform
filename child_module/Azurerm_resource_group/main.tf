

variable "rgs" {}


resource "azurerm_resource_group" "test1" {
  for_each = var.rgs
  name     = each.value.name
  location = each.value.location
}