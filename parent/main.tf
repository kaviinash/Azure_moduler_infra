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
   subnet_name = var.subnet_name
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

   module "public_ip" {
    source = "../modules/azurerm_public_ip"
     resource_group_name = module.resource_group.resource_group_name
     public_ip_name = var.public_ip_name
     public_ip_allocation_method = var.public_ip_allocation_method
     depends_on = [module.resource_group]
     }