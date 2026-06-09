data "azurerm_client_config" "current" {
  
}

data "azurerm_resource_group" "resource_group_data_block" {
    name = var.resource_group_name  
}

data "azurerm_key_vault" "key_vault_data_block" {
   name = var.key_vault_name
   resource_group_name = data.azurerm_resource_group.resource_group_data_block.name
  
}

resource "azurerm_role_assignment" "key_vault_role" {
    scope = data.azurerm_key_vault.key_vault_data_block.id
    role_definition_name = "Key Valut Admin"
    principal_id = data.azurerm_client_config.current.object_id
  
}

resource "azurerm_key_vault_secret" "frontend_vm_username_secret" {
    name =  var.frontend_vm_admin_username_key
    value = var.frontend_vm_admin_username_value
    key_vault_id = data.azurerm_key_vault.key_vault_data_block.id
    depends_on = [azurerm_role_assignment.key_vault_role]      
}

resource "azurerm_key_vault_secret" "frontend_vm_password_secret" {
    name =  var.frontend_vm_admin_password_key
    value = var.frontend_vm_admin_password_value
    key_vault_id = data.azurerm_key_vault.key_vault_data_block.id
    depends_on = [azurerm_role_assignment.key_vault_role]      
}

resource "azurerm_key_vault_secret" "backend_vm_username_secret" {
    name =  var.backend_vm_admin_username_key
    value = var.backend_vm_admin_username_value
    key_vault_id = data.azurerm_key_vault.key_vault_data_block.id
    depends_on = [azurerm_role_assignment.key_vault_role]      
}

resource "azurerm_key_vault_secret" "backend_vm_password_secret" {
    name =  var.backend_vm_admin_password_key
    value = var.backend_vm_admin_password_value
    key_vault_id = data.azurerm_key_vault.key_vault_data_block.id
    depends_on = [azurerm_role_assignment.key_vault_role]      
}

resource "azurerm_key_vault_secret" "sql_server_admin_login_secret" {
  name         = var.sql_server_admin_login_key
  value        = var.sql_server_admin_login_value
  key_vault_id = data.azurerm_key_vault.key_vault_data_block.id
  depends_on = [azurerm_role_assignment.key_vault_role]
}

resource "azurerm_key_vault_secret" "sql_server_admin_password" {
  name         = var.sql_server_admin_password_key
  value        = var.sql_server_admin_password_value
  key_vault_id = data.azurerm_key_vault.key_vault_data_block.id
  depends_on = [azurerm_role_assignment.key_vault_role]
}