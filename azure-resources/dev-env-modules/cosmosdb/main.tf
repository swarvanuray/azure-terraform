resource "azurerm_cosmosdb_account" "this" {
  name                = var.cosmos_name       # Must match existing Azure name exactly
  resource_group_name = var.rg_name
  location            = var.location
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"    # Usually "GlobalDocumentDB" (SQL) or "MongoDB"
  
  consistency_policy {
    consistency_level = "Session" # We will fix this later if it's wrong
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}