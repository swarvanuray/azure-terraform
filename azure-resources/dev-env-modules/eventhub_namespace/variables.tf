# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable EventHub Namespace creation"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the EventHub Namespace"
}

variable "namespace_name" {
  type        = string
  description = "Name of the EventHub Namespace (must be globally unique, 6-50 characters)"
}

# --- Optional ---
variable "sku" {
  type        = string
  default     = "Standard"
  description = "SKU for the EventHub Namespace. Possible values: Basic, Standard, Premium"
}

variable "capacity" {
  type        = number
  default     = 1
  description = "Throughput Units for a Standard SKU namespace (1-20). Not applicable to Basic or Premium SKUs"
}

variable "auto_inflate_enabled" {
  type        = bool
  default     = false
  description = "Is Auto Inflate enabled for the EventHub Namespace? Only available for Standard SKU"
}

variable "maximum_throughput_units" {
  type        = number
  default     = null
  description = "Maximum number of throughput units when Auto Inflate is enabled (1-20)"
}

variable "local_authentication_enabled" {
  type        = bool
  default     = true
  description = "Is SAS authentication enabled for the EventHub Namespace?"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Is public network access enabled for the EventHub Namespace?"
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "The minimum supported TLS version. Possible values: 1.0, 1.1, 1.2"
}

# --- Identity ---
variable "identity_type" {
  type        = string
  default     = null
  description = "Specifies the identity type. Possible values: SystemAssigned, UserAssigned"
}

variable "identity_ids" {
  type        = list(string)
  default     = null
  description = "A list of user managed identity IDs. Required if identity_type is UserAssigned"
}

# --- Tags ---
variable "tags" {
  type = map(string)
  default = {
    CreatedBy = "Terraform"
    Module    = "EventHubNamespace"
  }
  description = "A mapping of tags to assign to the resource"
}
