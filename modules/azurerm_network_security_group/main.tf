data  "azurerm_resource_group" "resource_group_data_block" {
  name = var.resource_group_name
  
}

resource "azurerm_network_security_group" "network_security_group"{
    name = var.network_security_group_name
    location = data.azurerm_resource_group.resource_group_data_block.location
    resource_group_name = data.azurerm_resource_group.resource_group_data_block.name
}

resource "azurerm_network_security_rule" "network_security_rule" {
    for_each = var.security_rules
    name = each.key
    priority = each.value.priority
    direction = each.value.direction
    access = each.value.access  
    protocol = each.value.protocol
    
    resource_group_name = data.azurerm_resource_group.resource_group_data_block.name
    network_security_group_name = azurerm_network_security_group.network_security_group.name

    source_port_range = each.value.source_port_range
    destination_port_range = each.value.destination_port_range

    source_address_prefix = each.value.source_address_prefix
    destination_address_prefix = each.value.destination_address_prefix

    description = each.value.description
    depends_on = [azurerm_network_security_group.network_security_group]
}