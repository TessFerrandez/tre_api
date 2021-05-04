provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "fastapi_rg"{
  name = "fastapi-rg"
  location = "westeurope"
}

resource "azurerm_app_service_plan" "api_service_plan" {
  location = "westeurope"
  name = "treapi-1234"
  resource_group_name = "fastapi-rg"
  kind = "linux"
  reserved = true
  sku {
    size = "F1"
    tier = "Free"
  }
}
