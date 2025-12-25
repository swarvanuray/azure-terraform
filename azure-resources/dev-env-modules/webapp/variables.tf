variable "rg_name" { type = string }
variable "location" { type = string }

variable "service_plan_sku" {
  type    = string
  default = "B1" # Basic tier (Required for multiple apps)
}

# NEW: A map to define multiple apps
variable "web_apps" {
  description = "Map of web apps to create"
  type        = map(object({
    dotnet_version = optional(string)
    node_version   = optional(string)
  }))
  default = {
    "frontend" = { node_version = "18-lts" }
    "api"      = { dotnet_version = "7.0" }
  }
}