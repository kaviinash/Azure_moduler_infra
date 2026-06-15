module "resource_group" {
  source = "../modules/azurerm_resource_group"
   resource_group_name = var.resource_group_name
   resource_group_location = var.resource_group_location

}

module "virtual_network" {
  source = "../modules/azurerm_virtual_network"
   resource_group_name = module.resource_group.resource_group_name
   virtual_network_name = var.virtual_network_name
   virtual_network_address_space = var.virtual_network_address_space
   depends_on = [module.resource_group]

}

module "frontend_subnet" {
  source = "../modules/azurerm_subnet"
   resource_group_name = module.resource_group.resource_group_name
   virtual_network_name = module.virtual_network.virtual_network_output_block
   subnet_name = var.frontend_subnet_name
   subnet_address_prefixes = var.subnet_address_prefixes
   depends_on = [module.virtual_network]
   }

module "backend_subnet" {
  source = "../modules/azurerm_subnet"
   resource_group_name = module.resource_group.resource_group_name
   virtual_network_name = module.virtual_network.virtual_network_output_block
   subnet_name = var.backend_subnet_name
   subnet_address_prefixes = var.subnet_address_prefixes
   depends_on = [module.virtual_network]
   }

   module "frontend_public_ip" {
    source = "../modules/azurerm_public_ip"
     resource_group_name = module.resource_group.resource_group_name
     public_ip_name = var.frontend_public_ip_name
     public_ip_allocation_method = var.public_ip_allocation_method
     depends_on = [module.resource_group]
     }
    
   module "frontend-network_security_group" {
    source = "../modules/azurerm_network_security_group"
    resource_group_name = module.resource_group.resource_group_name
    network_security_group_name = var.frontend_network_security_group_name
    security_rules = {
        allow_ssh = {
            priority = 100
            direction = "Inbound"
            access = "Allow"
            protocol = "Tcp"
            source_port_range = "*"
            destination_port_range = "22"
            source_address_prefix = "*"
            destination_address_prefix = "*"
            description = "Allow SSH traffic from any source to any destination on port 22."
        }
     }
     depends_on = [module.resource_group]
     }
   
   module "backend_public_ip" {
    source = "../modules/azurerm_public_ip"
     resource_group_name = module.resource_group.resource_group_name
     public_ip_name = var.backend_public_ip_name
     public_ip_allocation_method = var.public_ip_allocation_method
     depends_on = [module.resource_group]
     }

   module "backend-network_security_group" {
    source = "../modules/azurerm_network_security_group"
    resource_group_name = module.resource_group.resource_group_name
    network_security_group_name = var.backend_network_security_group_name
    security_rules = {
        allow_ssh = {
            priority = 110
            direction = "Inbound"
            access = "Allow"
            protocol = "Tcp"
            source_port_range = "*"
            destination_port_range = "22"
            source_address_prefix = "*"
            destination_address_prefix = "*"
            description = "Allow SSH traffic from any source to any destination on port 22."
        }
      allow_http = {
            priority = 110
            direction = "Inbound"
            access = "Allow"
            protocol = "Tcp"
            source_port_range = "*"
            destination_port_range = "8080"
            source_address_prefix = "*"
            destination_address_prefix = "*"
            description = "Allow SSH traffic from any source to any destination on port 8080."
        }
     }
     depends_on = [module.resource_group]
     }

module "frontend_network_interface" {
  source = "../modules/azurerm_network_interface"
  resource_group_name = module.resource_group.resource_group_name
  network_interface_name = var.frontend_network_interface_name
  network_interface_ip_configuration_name = var.front_end_nic_ip_config_name
  public_ip_name =       module.frontend_public_ip.public_ip_name
  virtual_network_name = module.virtual_network.virtual_network_output_block
  subnet_name =           module.frontend_subnet.subnet_name
  network_security_group_name = var.frontend_network_security_group_name
  depends_on = [ module.frontend_subnet ]     
}

module "back_network_interface" {
  source = "../modules/azurerm_network_interface"
  resource_group_name = module.resource_group.resource_group_name
  network_interface_name = var.backend_network_interface_name
  network_interface_ip_configuration_name = var.backend_nic_ip_config_name
  public_ip_name =       module.backend_public_ip.public_ip_name
  virtual_network_name = module.virtual_network.virtual_network_output_block
  subnet_name =           module.backend_subnet.subnet_name
  network_security_group_name = var.frontend_network_security_group_name
  depends_on = [ module.backend_subnet ]     
}

module "key_vault" {
  source = "../modules/azurerm_key_vault"
  resource_group_name = module.resource_group.resource_group_name
  key_vault_name = var.key_vault_name
  depends_on = [ module.resource_group ]
  
}

module "key_vault_secrets" {
  source = "../modules/azurerm_key_vault_secret"
  resource_group_name = module.resource_group.resource_group_name
  key_vault_name = module.key_vault.key_vault_output_block

  frontend_vm_admin_username_key =  var.frontend_username_key
  frontend_vm_admin_username_value = var.frontend_username_value
  frontend_vm_admin_password_key =  var.frontend_password_key
  frontend_vm_admin_password_value = var. frontend_password_value

  backend_vm_admin_username_key =  var.backend_username_key
  backend_vm_admin_username_value = var.backend_username_value
  backend_vm_admin_password_key =  var.backend_password_key
  backend_vm_admin_password_value = var.backend_password_value

  sql_server_admin_login_key = var.sql_server_admin_login_key
  sql_server_admin_login_value = var. sql_server_admin_login_value
  sql_server_admin_password_key = var.sql_server_admin_password_key
  sql_server_admin_password_value = var.sql_Server_admin_password_value

  depends_on = [ module.key_vault,module.resource_group ]


}

