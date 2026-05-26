output "rule_ids" {
  description = "Map of NSG rule IDs"
  value = {
    for k, v in azurerm_network_security_rule.this :
    k => v.id
  }
}

output "rule_names" {
  description = "Rule names"
  value       = keys(azurerm_network_security_rule.this)
}