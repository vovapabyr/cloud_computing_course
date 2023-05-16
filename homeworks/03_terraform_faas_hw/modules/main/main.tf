resource "azurerm_resource_group" "faas" {
  name     = "${var.prefix}-faas-rg"
  location = var.location
}