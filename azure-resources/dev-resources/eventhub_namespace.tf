module "eventhub_namespace" {
  source = "../dev-env-modules/eventhub_namespace"

  rg_name         = data.azurerm_resource_group.existing_rg.name
  location        = data.azurerm_resource_group.existing_rg.location
  namespace_name  = "swarvanu-eventhub-ns" # REPLACE THIS with your desired EventHub Namespace name
  create_resource = true
}

output "eventhub_namespace_id" {
  value = module.eventhub_namespace.namespace_id
}

output "eventhub_namespace_name" {
  value = module.eventhub_namespace.namespace_name
}
