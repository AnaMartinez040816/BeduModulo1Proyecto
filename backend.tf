terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=3.3.0"
        } 
    }
}

#Configura Microsoft Azure Provider
provider "azurerm" {
    features {
        key_vault {
          purge_soft_deleted_certificates_on_destroy = true
          purge_soft_deleted_keys_on_destroy         = true
          purge_soft_deleted_secrets_on_destroy      = true
          recover_soft_deleted_certificates          = true
          recover_soft_deleted_secrets               = true
          recover_soft_deleted_keys                  = true
        }
    }
}
