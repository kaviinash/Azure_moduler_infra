variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

variable "virtual_network_name" {
    description = "The name of the virtual network."
    type        = string
}

variable "virtual_network_address_space" {
    description = "The address space of the virtual network."
    type        = list(string)
}

variable "subnet_name" {
    description = "The name of the subnet."
    type        = string
}

variable "subnet_address_prefixes" {
    description = "The address prefixes of the subnet."
    type        = list(string)
}

variable "backend_subnet_name" {
    description = "The name of the subnet."
    type        = string
}

variable "public_ip_name" {
  type = string 
}
variable "public_ip_allocation_method" {
  type    = string
  default = "Static"
}





