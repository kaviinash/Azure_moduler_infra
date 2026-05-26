variable "resource_group_name" {
  description = "The name of the resource group in which the network interface will be created."
  type        = string
}
variable "network_security_group_name" {
  description = "The name of the network security group to create."
  type        = string
}

variable "security_rules" {
  description = "Map of NSG security rules"

  type = map(object({
    priority  = number
    direction = string
    access    = string
    protocol  = string

    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string)
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")

    description = optional(string)
  }))

  default = {}
}