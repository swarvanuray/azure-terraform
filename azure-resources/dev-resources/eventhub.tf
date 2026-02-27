module "eventhub" {
  source = "../dev-env-modules/eventhub"

  rg_name           = data.azurerm_resource_group.existing_rg.name
  eventhub_name     = "swarvanu-eventhub" # REPLACE THIS with your desired EventHub name
  namespace_name    = module.eventhub_namespace.namespace_name
  partition_count   = 2
  message_retention = 1
  create_resource   = true
}

output "eventhub_id" {
  value = module.eventhub.eventhub_id
}

output "eventhub_name" {
  value = module.eventhub.eventhub_name
}
