# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable Log Analytics Workspace creation"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the Log Analytics Workspace"
}

variable "workspace_name" {
  type        = string
  description = "Name of the Log Analytics Workspace (4-63 letters, digits or '-')"
}

# --- Optional ---
variable "sku" {
  type        = string
  default     = "PerGB2018"
  description = "SKU for the Log Analytics Workspace. Possible values: PerGB2018, PerNode, Premium, Standalone, Standard, CapacityReservation, LACluster, Unlimited"
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "The workspace data retention in days (30-730)"
}

variable "allow_resource_only_permissions" {
  type        = bool
  default     = true
  description = "Allow users to access data associated with resources they have permission to view, without workspace-level permission"
}

variable "local_authentication_enabled" {
  type        = bool
  default     = true
  description = "Allow local authentication methods in addition to Microsoft Entra (Azure AD)"
}

variable "daily_quota_gb" {
  type        = number
  default     = -1
  description = "The workspace daily quota for ingestion in GB. -1 means unlimited"
}

variable "cmk_for_query_forced" {
  type        = bool
  default     = false
  description = "Is Customer Managed Storage mandatory for query management?"
}

variable "internet_ingestion_enabled" {
  type        = bool
  default     = true
  description = "Should the Log Analytics Workspace support ingestion over the Public Internet?"
}

variable "internet_query_enabled" {
  type        = bool
  default     = true
  description = "Should the Log Analytics Workspace support querying over the Public Internet?"
}

variable "reservation_capacity_in_gb_per_day" {
  type        = number
  default     = null
  description = "The capacity reservation level in GB. Possible values: 100, 200, 300, 400, 500, 1000, 2000, 5000. Only used when sku is CapacityReservation"
}

variable "data_collection_rule_id" {
  type        = string
  default     = null
  description = "The ID of the Data Collection Rule to use for this workspace"
}

variable "immediate_data_purge_on_30_days_enabled" {
  type        = bool
  default     = false
  description = "Whether to remove the data in the Log Analytics Workspace immediately after 30 days"
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
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
    Module    = "LogAnalyticsWorkspace"
  }
  description = "A mapping of tags to assign to the resource"
}
