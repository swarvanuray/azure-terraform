variable "subnets" {
  description = "Map of subnets to create with optional delegation"
  type        = map(object({
    address_prefixes = list(string)
    delegation       = optional(string) # "Microsoft.Web/serverFarms" for Web Apps
  }))
  # Default example
  default = {
    "web-subnet" = { 
      address_prefixes = ["10.0.1.0/24"]
      delegation       = "Microsoft.Web/serverFarms" 
    }
    "db-subnet"  = { 
      address_prefixes = ["10.0.2.0/24"]
      delegation       = null
    }
  }
}

variable "rg_name" { type = string }
variable "location" { type = string }
variable "base_name" {
  type    = string
  default = "swarvanu-vnet"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}