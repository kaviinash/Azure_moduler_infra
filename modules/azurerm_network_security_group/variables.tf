variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Security Group."
  type        = string
  
}

variable "network_security_group_name" {
  description = "The name of the Network Security Group."
  type        = string
}

variable "rules" {
  description = "A map of security rules to be applied to the Network Security Group. The key of the map is the name of the rule, and the value is an object containing the properties of the rule."
  type = map(object(
    { 
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string

    source_port_ranges         = optional(list(string))
    destination_port_ranges    = optional(list(string))

    source_address_prefixes    = optional(list(string))
    destination_address_prefixes = optional(list(string))

    source_application_security_group_ids      = optional(list(string))
    destination_application_security_group_ids = optional(list(string))

    description = optional(string)

  }
  ))
validation {
    condition = alltrue([
      for rule in values(var.rules) :
      contains(["Inbound", "Outbound"], rule.direction)
    ])
    error_message = "direction must be Inbound or Outbound."
  }

  validation {
    condition = alltrue([
      for rule in values(var.rules) :
      contains(["Allow", "Deny"], rule.access)
    ])
    error_message = "access must be Allow or Deny."
  }

  validation {
    condition = alltrue([
      for rule in values(var.rules) :
      rule.priority >= 100 && rule.priority <= 4096
    ])
    error_message = "priority must be between 100 and 4096."
  }
}

