# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable EventHub Authorization Rule creation"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "authorization_rule_name" {
  type        = string
  description = "Name of the EventHub Authorization Rule"
}

variable "namespace_name" {
  type        = string
  description = "Name of the EventHub Namespace"
}

variable "eventhub_name" {
  type        = string
  description = "Name of the EventHub"
}

# --- Optional ---
variable "listen" {
  type        = bool
  default     = true
  description = "Does this Authorization Rule have Listen access to the EventHub?"
}

variable "send" {
  type        = bool
  default     = true
  description = "Does this Authorization Rule have Send access to the EventHub?"
}

variable "manage" {
  type        = bool
  default     = false
  description = "Does this Authorization Rule have Manage access to the EventHub? When true, listen and send must also be true"
}
