terraform {
  required_version = "~>1.4.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.48.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

module "observability" {
  source = "../modules/observability"
  prefix   = var.prefix
  location = var.location
}

module "storage_account" {
  source = "../modules/storage_account"

  prefix   = var.prefix
  location = var.location
}

module "faas" {
  source = "../modules/faas"

  prefix   = var.prefix
  location = var.location

  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
}

module "vm_psql_net" {
  source = "../modules/vm_psql"

  prefix   = var.prefix
  location = var.location

  psql_admin        = var.psql_admin
  psql_password     = var.psql_password
  psql_storage_size = var.psql_storage_size
  psql_sku          = var.psql_sku

  vm_size           = var.vm_size

  log_analytics_workspace_id = module.observability.log_analytics_workspace_id
}
