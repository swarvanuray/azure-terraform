resource "azurerm_virtual_network" "this" {
  name                = var.base_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  # DYNAMIC DELEGATION BLOCK
  dynamic "delegation" {
    # Only create this block if 'delegation' variable is not null
    for_each = each.value.delegation != null ? [1] : []

    content {
      name = "delegation"
      service_delegation {
        name    = each.value.delegation
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}