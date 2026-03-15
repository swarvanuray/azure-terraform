# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable Application Gateway creation"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the Application Gateway"
}

variable "appgw_name" {
  type        = string
  description = "Name of the Application Gateway"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet for the Application Gateway"
}

variable "backend_ip_addresses" {
  type        = list(string)
  description = "List of backend VM private IP addresses for the backend pool"
}

# --- Optional ---
variable "sku_name" {
  type        = string
  default     = "Standard_v2"
  description = "SKU name of the Application Gateway (e.g. Standard_v2, WAF_v2)"
}

variable "sku_tier" {
  type        = string
  default     = "Standard_v2"
  description = "SKU tier of the Application Gateway (e.g. Standard_v2, WAF_v2)"
}

variable "sku_capacity" {
  type        = number
  default     = 2
  description = "Number of instances for the Application Gateway"
}

variable "frontend_port" {
  type        = number
  default     = 80
  description = "Frontend port for the Application Gateway listener"
}

variable "backend_port" {
  type        = number
  default     = 80
  description = "Backend port for the HTTP settings"
}

variable "cookie_based_affinity" {
  type        = string
  default     = "Disabled"
  description = "Cookie-based affinity setting (Enabled or Disabled)"
}

variable "request_timeout" {
  type        = number
  default     = 30
  description = "Request timeout in seconds for backend HTTP settings"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the Application Gateway resources"
}
