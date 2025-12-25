terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "764444e2-3113-461c-b2ca-7bb5df60fb41"

  # ADD THIS LINE TO FIX THE ERROR:
  resource_provider_registrations = "none"
}