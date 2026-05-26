data azurerm_resource_group resource_group_data_block {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "azurerm_network_security_group" {
  name                = var.network_security_group_name
  location            = data.azurerm_resource_group.resource_group_data_block.location
  resource_group_name = data.azurerm_resource_group.resource_group_data_block.name

}

resource "azurerm_network_security_rule" "this" {
  for_each = var.rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol

  resource_group_name         = data.azurerm_resource_group.resource_group_data_block.name
  network_security_group_name = var.network_security_group_name

  source_port_ranges          = try(each.value.source_port_ranges, ["*"])
  destination_port_ranges     = try(each.value.destination_port_ranges, ["*"])

  source_address_prefixes     = try(each.value.source_address_prefixes, ["*"])
  destination_address_prefixes = try(each.value.destination_address_prefixes, ["*"])

  source_application_security_group_ids = try(
    each.value.source_application_security_group_ids,
    null
  )

  destination_application_security_group_ids = try(
    each.value.destination_application_security_group_ids,
    null
  )

  description = try(each.value.description, null)

  lifecycle {
    create_before_destroy = true
  }
}