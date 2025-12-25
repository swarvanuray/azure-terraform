output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  # Returns a map of all created subnet IDs (useful for other modules)
  value = { for name, subnet in azurerm_subnet.this : name => subnet.id }
}