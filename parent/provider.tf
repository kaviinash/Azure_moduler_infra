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
    subscription_id = "a68971e4-ef99-48a7-a87c-c9a7f7d03b22"
}