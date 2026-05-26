variable "key_vault_name" {
    description = "The name of the Key Vault. Changing this forces a new resource to be created."
    type        = string
  
}
variable "sku_name" {
    description = "The SKU name of the Key Vault. Possible values are: 'standard' and 'premium'."
    type        = string
    default     = "standard"

}

variable "soft_delete_enabled" {
    description = "Specifies whether soft delete is enabled for the Key Vault. Defaults to true."
    type        = bool
    default     = true
}

variable "purge_protection_enabled" {
    description = "Specifies whether purge protection is enabled for the Key Vault. Defaults to false."
    type        = bool
    default     = false
}

variable "enabled_for_deployment" {
    description = "Specifies whether Azure Resource Manager can deploy to the Key Vault. Defaults to false."
    type        = bool
    default     = false
}


variable "enabled_for_template_deployment" {
    description = "Specifies whether Azure Resource Manager can deploy to the Key Vault using templates. Defaults to false."
    type        = bool
    default     = false
}

variable "resource_group_name" {
    description = "The name of the resource group in which to create the Key Vault."
    type        = string
}

variable "soft_delete_retention_days" {
    description = "Specifies the number of days that the Key Vault will be retained after deletion. This is only applicable if soft delete is enabled. Defaults to 90."
    type        = number
    default     = 7
}


