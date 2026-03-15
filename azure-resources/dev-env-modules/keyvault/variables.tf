# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable Key Vault creation"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the Key Vault"
}

variable "keyvault_name" {
  type        = string
  description = "Name of the Key Vault (must be globally unique, 3-24 characters)"
}

# --- Optional ---
variable "sku_name" {
  type        = string
  default     = "standard"
  description = "SKU for the Key Vault (standard or premium)"
}

variable "soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "Number of days to retain soft-deleted vaults (7-90)"
}

variable "purge_protection_enabled" {
  type        = bool
  default     = false
  description = "Enable purge protection to prevent permanent deletion during retention period"
}

variable "network_default_action" {
  type        = string
  default     = "Allow"
  description = "Default network action (Allow or Deny)"
}

variable "network_bypass" {
  type        = string
  default     = "AzureServices"
  description = "Specifies which traffic can bypass the network rules (AzureServices or None)"
}

variable "deployer_key_permissions" {
  type        = list(string)
  default     = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore"]
  description = "Key permissions for the deploying service principal"
}

variable "deployer_secret_permissions" {
  type        = list(string)
  default     = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
  description = "Secret permissions for the deploying service principal"
}

# --- Additional Access Policies ---
variable "additional_access_policies" {
  type = map(object({
    object_id               = string
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
  }))
  default     = {}
  description = "Map of additional access policies to create (for other users, groups, or service principals)"
}

