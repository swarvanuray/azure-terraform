# Get current Azure client configuration for tenant_id and object_id
data "azurerm_client_config" "current" {}

# 1. Create the Key Vault
resource "azurerm_key_vault" "this" {
  count = var.create_resource ? 1 : 0

  name                = var.keyvault_name
  resource_group_name = var.rg_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  # Bootstrap deployer permissions during vault creation so provider
  # data-plane reads (like certificate contacts) can succeed immediately.
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions         = var.deployer_key_permissions
    secret_permissions      = var.deployer_secret_permissions
    certificate_permissions = var.deployer_certificate_permissions
  }

  # Soft delete & purge protection
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  # Network ACLs
  network_acls {
    default_action = var.network_default_action
    bypass         = var.network_bypass
  }

  tags = {
    CreatedBy = "Terraform"
    Module    = "KeyVault"
  }
}

# 2. Additional Access Policies (for other users, groups, or service principals)
resource "azurerm_key_vault_access_policy" "additional" {
  for_each = var.create_resource ? var.additional_access_policies : {}

  key_vault_id = azurerm_key_vault.this[0].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value.object_id

  key_permissions         = lookup(each.value, "key_permissions", [])
  secret_permissions      = lookup(each.value, "secret_permissions", [])
  certificate_permissions = lookup(each.value, "certificate_permissions", [])
}
