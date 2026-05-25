module "resource_group" {
  source = "../modules/azurerm_resource_group"
   resource_group_name = var.resource_group_name
   resource_group_location = var.resource_group_location

}