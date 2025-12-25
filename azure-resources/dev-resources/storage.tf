# 1. Look up the EXISTING Resource Group "swarvanu"
data "azurerm_resource_group" "existing_rg" {
  name = "swarvanu"
}

# 2. Call the Module (All complexity is hidden)
module "auto_storage" {
  source = "../dev-env-modules/azure-blob"

  # Pass only the location and name from the existing RG
  rg_name  = data.azurerm_resource_group.existing_rg.name
  location = data.azurerm_resource_group.existing_rg.location
}
