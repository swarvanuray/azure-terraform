# 1. Create ONE Shared Service Plan
resource "azurerm_service_plan" "shared_plan" {
  name                = "swarvanu-shared-plan"
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
}

# 2. Create MULTIPLE Web Apps using for_each
resource "azurerm_linux_web_app" "this" {
  for_each = var.web_apps  # <--- The Meta-Argument Loop

  name                = "swarvanu-${each.key}-app" # Result: swarvanu-frontend-app
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.shared_plan.id

  site_config {
    always_on = false
    
    application_stack {
      # Use the version if provided, otherwise null
      node_version   = try(each.value.node_version, null)
      dotnet_version = try(each.value.dotnet_version, null)
    }
  }

  tags = {
    Module = "AutoWebApp"
    App    = each.key
  }
}