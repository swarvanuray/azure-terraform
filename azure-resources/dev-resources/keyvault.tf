module "my_keyvault" {
  source = "../dev-env-modules/keyvault"

  rg_name       = data.azurerm_resource_group.existing_rg.name
  location      = data.azurerm_resource_group.existing_rg.location
  keyvault_name = "swarvanukeyvault" # REPLACE THIS with your desired Key Vault name
}

output "keyvault_id" {
  value = module.my_keyvault.keyvault_id
}

output "keyvault_uri" {
  value = module.my_keyvault.keyvault_uri
}
