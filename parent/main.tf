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