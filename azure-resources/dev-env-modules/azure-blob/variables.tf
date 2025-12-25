variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable creation"
}

variable "rg_name" { type = string }
variable "location" { type = string }
variable "storage_name" {
  type        = string
  default     = "swarvanu"  # <--- Added default value
  description = "Base name for the storage account"
}

variable "account_tier" { default = "Standard" }
variable "replication_type" { default = "LRS" } # Options: LRS, GRS, ZRS
variable "access_tier" { default = "Hot" }      # Options: Hot, Cool
variable "min_tls" { default = "TLS1_2" }

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Enable blob versioning for data recovery"
}

