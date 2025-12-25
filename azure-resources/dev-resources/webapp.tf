data "azurerm_resource_group" "rg_web" {
  name = "swarvanu"
}

locals {
  web_apps = {
    "payment-api" = { dotnet_version = "8.0" }
  }
}

module "multiple_webapps" {
  source = "../dev-env-modules/webapp"

  rg_name  = data.azurerm_resource_group.rg_web.name
  location = "Central US"
   service_plan_sku = "F1"
  # Define your Multiple Apps here
  web_apps = local.web_apps
}
