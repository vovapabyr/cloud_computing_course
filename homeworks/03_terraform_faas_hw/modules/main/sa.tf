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

resource "azurerm_storage_container" "messages" {
  name                  = "messages"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "messages" {
  name                   = "messages.json"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.messages.name
  type                   = "Append"
}