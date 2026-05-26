variable "public_ip_name" {
  type = string 
}
variable "public_ip_allocation_method" {
  type    = string
  default = "Static"
}

variable "resource_group_name" {
  type = string
}
