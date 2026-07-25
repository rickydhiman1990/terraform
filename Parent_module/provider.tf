terraform {
   backend "azurerm" {
    resource_group_name  = "piplineprac-01"
    storage_account_name = "pipe0102"
    container_name       = "rajric"
    key                  = "ladle.tfstate" 
    }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }

   
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  #   resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  subscription_id = "fb84669e-67bb-40cb-8555-8122471924cf"
}