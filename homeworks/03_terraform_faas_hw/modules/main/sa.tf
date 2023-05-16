resource "azurerm_storage_account" "sa" {
  name                = "${var.prefix}sa"
  location            = azurerm_resource_group.faas.location
  resource_group_name = azurerm_resource_group.faas.name

  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
}

resource "azurerm_storage_table" "messages" {
  name                 = "messages"
  storage_account_name = azurerm_storage_account.sa.name
}
