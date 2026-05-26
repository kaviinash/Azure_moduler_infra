data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "resource_group_data_block" {
  name = var.resource_group_name
}

resource "azurerm_key_vault" "key_vault"{
    name                        = var.key_vault_name
    location                    = data.azurerm_resource_group.resource_group_data_block.location
    resource_group_name         = data.azurerm_resource_group.resource_group_data_block.name
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    sku_name                    = var.sku_name
    soft_delete_retention_days  = var.soft_delete_retention_days 
    purge_protection_enabled     = var.purge_protection_enabled
    enabled_for_deployment      = var.enabled_for_deployment  
    enabled_for_template_deployment = var.enabled_for_template_deployment
}