module "my_cosmos" {
  source = "../dev-env-modules/cosmosdb"

  rg_name     = data.azurerm_resource_group.existing_rg.name
  location    = data.azurerm_resource_group.existing_rg.location
  cosmos_name = "swarvanucosmos" # REPLACE THIS with the real name
}