terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Reference existing resource group
data "azurerm_resource_group" "rg" {
  name = "practiceResourceGroup"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "terraform-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = "South Africa North"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet_frontend_servers" {
  name                 = "subnet-frontend-servers"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet_backend_servers" {
  name                 = "subnet-backend-servers"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
