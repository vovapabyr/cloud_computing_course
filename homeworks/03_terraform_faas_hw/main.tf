terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "main" {
  source   = "./modules/main"
  prefix   = var.prefix
  location = var.location
}

module "subscription" {
  source              = "./modules/subscription"
  event_grid_topic_id = module.main.event_grid_topic_id
  function_app_id     = module.main.function_app_id
}