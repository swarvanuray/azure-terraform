output "eventhub_id" {
  description = "The ID of the EventHub"
  value       = try(azurerm_eventhub.this[0].id, "Not Created")
}

output "eventhub_name" {
  description = "The name of the EventHub"
  value       = try(azurerm_eventhub.this[0].name, "Not Created")
}

output "partition_ids" {
  description = "The identifiers for the partitions of the EventHub"
  value       = try(azurerm_eventhub.this[0].partition_ids, [])
}
