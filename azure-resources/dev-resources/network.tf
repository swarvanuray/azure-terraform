data "azurerm_resource_group" "rg_net" {
  name = "swarvanu"
}

module "my_network" {
  source = "../dev-env-modules/network"
  
  rg_name  = data.azurerm_resource_group.rg_net.name
  location = data.azurerm_resource_group.rg_net.location

  subnets = {
    # THIS IS THE CRITICAL CHANGE: Adding delegation
    "web-subnet" = { 
      address_prefixes = ["10.0.1.0/24"] 
      delegation = {
        name = "webappdelegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
    "db-subnet"  = { 
      address_prefixes = ["10.0.2.0/24"] 
      delegation       = null 
    }
  }
}