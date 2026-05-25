terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.74.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = "d1b8c9e7-5a0c-4f1b-9e3c-2a1b2c3d4e5f"
}