provider "azurerm" {
    features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

terraform {
    backend "azurerm" {
        resource_group_name  = "localstorage"
        storage_account_name = "localstorageaccount12"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
  name="tfmainrg"
  location = "UKSouth"
}

resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapi"
  location            = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "Public"
  dns_name_label  = "riteshpatelwapi"
  os_type         = "Linux"

  container {
      name              = "weatherapi"
      image             = "ritesh69patel/weatherapi"
        cpu             = "1"
        memory          = "1"
        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}