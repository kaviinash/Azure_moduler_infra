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

variable "frontend_subnet_name" {
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

variable "frontend_public_ip_name" {
  type = string 
}
variable "backend_public_ip_name" {
  type = string 
}

variable "public_ip_allocation_method" {
  type    = string
  default = "Static"
}

variable "frontend_network_security_group_name" {
  description = "The name of the network security group to create."
  type        = string
}

variable "backend_network_security_group_name" {
  description = "The name of the network security group to create."
  type        = string
}

variable "frontend_network_interface_name" {
  description = "The name of the network interface to create for the frontend subnet."
  type        = string
}

variable "front_end_nic_ip_config_name" {
  description = "The name of front end NIC IP Configuration"
  type = string
}



