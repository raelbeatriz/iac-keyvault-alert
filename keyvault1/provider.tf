provider "azurerm" {
  features {}
  subscription_id = ""
}

terraform {
  required_version = ">=1.11"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}
