output "subnet_name" {
    description = "The name of the subnet."
    value       = azurerm_subnet.subnet_block.name
}