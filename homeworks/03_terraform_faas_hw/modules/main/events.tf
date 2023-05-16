resource "azurerm_eventgrid_topic" "events" {
  name                = "${var.prefix}-events"
  location            = var.location
  resource_group_name = azurerm_resource_group.faas.name

  identity {
    type = "SystemAssigned"
  }
}


