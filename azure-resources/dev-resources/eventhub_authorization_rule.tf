module "eventhub_authorization_rule" {
  source = "../dev-env-modules/eventhub_authorization_rule"

  rg_name                 = data.azurerm_resource_group.existing_rg.name
  authorization_rule_name = "swarvanu-eventhub-auth-rule" # REPLACE THIS with your desired rule name
  namespace_name          = module.eventhub_namespace.namespace_name
  eventhub_name           = module.eventhub.eventhub_name
  listen                  = true
  send                    = true
  manage                  = false
  create_resource         = true
}

output "eventhub_auth_rule_id" {
  value = module.eventhub_authorization_rule.authorization_rule_id
}

output "eventhub_auth_rule_name" {
  value = module.eventhub_authorization_rule.authorization_rule_name
}
