resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.prefix}-la"
  location            = azurerm_resource_group.faas.location
  resource_group_name = azurerm_resource_group.faas.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  internet_ingestion_enabled = false
}