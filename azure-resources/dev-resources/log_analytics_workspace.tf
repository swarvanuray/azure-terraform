module "log_analytics" {
  source = "../dev-env-modules/log_analytics_workspace"

  rg_name        = data.azurerm_resource_group.existing_rg.name
  location       = data.azurerm_resource_group.existing_rg.location
  workspace_name = "swarvanu-log-analytics"
}

output "log_analytics_workspace_id" {
  value = module.log_analytics.workspace_id
}

output "log_analytics_workspace_name" {
  value = module.log_analytics.workspace_name
}
