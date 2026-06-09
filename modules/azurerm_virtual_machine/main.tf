data "azurerm_resource_group" "resource_group_data_block" {
    name = var.resource_group_name 
}

data "azurerm_network_interface" "network_interface_data_block" {
    name = var.network_interface_name
    resource_group_name = data.azurerm_resource_group.resource_group_data_block.name
  
}
