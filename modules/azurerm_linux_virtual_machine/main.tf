data "azurerm_resource_group" "resource_group_data_block" {
    name = var.resource_group_name
}

data "azurerm_network_interface" "network_interface_data_block" {
    name = var.network_interface_name
    resource_group_name = data.azurerm_resource_group.resource_group_data_block.name  
}

data "azurerm_key_vault" "key_vault_data_block" {
    name =  var.key_vault_name
    resource_group_name = data.azurerm_resource_group.resource_group_data_block.name
  
}

data "azurerm_key_vault_secret" "key_vault_password_data_block" {
    name = var.vm_admin_password
    key_vault_id = data.azurerm_key_vault.key_vault_data_block.id

  
}

data "azurerm_key_vault_secret" "key_vault_username_data_block" {
    name = var.vm_admin_username
    key_vault_id = data.azurerm_key_vault.key_vault_data_block.id
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
    name = var.vm_name
    resource_group_name = data.azurerm_resource_group.resource_group_data_block.name
    location = data.azurerm_resource_group.resource_group_data_block.location
    size = var.vm_size
    admin_username = data.azurerm_key_vault_secret.key_vault_username_data_block.value
    admin_password = data.azurerm_key_vault_secret.key_vault_password_data_block.value
    network_interface_ids = [data.azurerm_network_interface.network_interface_data_block.id]
    disable_password_authentication = false

    os_disk {
        caching ="ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    
    source_image_reference{
        publisher = var.vm_publisher
        offer     = var.vm_offer
        sku       = var.vm_sku
        version   = var.vm_version
    }

}