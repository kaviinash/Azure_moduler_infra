data "azurerm_resource_group" "resource_group_data_block" {
  name = var.resource_group_name
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = data.azurerm_resource_group.resource_group_data_block.name
  location            = data.azurerm_resource_group.resource_group_data_block.location
  allocation_method   = var.public_ip_allocation_method
  

}