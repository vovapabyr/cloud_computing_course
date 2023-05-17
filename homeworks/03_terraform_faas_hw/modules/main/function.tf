locals {
  function_base_name           = "${var.prefix}-func"
  app_service_plan_name        = "${local.function_base_name}-plan"
  app_insights_name            = "${local.function_base_name}-appinsights"
  function_http_to_event_name  = "${local.function_base_name}-http-to-event"
  function_event_to_table_name = "${local.function_base_name}-event-to-table"
}

resource "azurerm_storage_account" "faas_storage" {
  name                     = "${var.prefix}funcsa"
  resource_group_name      = azurerm_resource_group.faas.name
  location                 = azurerm_resource_group.faas.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "faas" {
  name                = local.app_service_plan_name
  location            = azurerm_resource_group.faas.location
  resource_group_name = azurerm_resource_group.faas.name
  kind                = "functionapp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_application_insights" "app_insights" {
  name                = local.app_insights_name
  location            = azurerm_resource_group.faas.location
  resource_group_name = azurerm_resource_group.faas.name
  application_type    = "web"

  daily_data_cap_in_gb = 10
  retention_in_days    = 90
  sampling_percentage  = 100
}

resource "azurerm_function_app" "faas" {
  name                       = local.function_base_name
  location                   = azurerm_resource_group.faas.location
  resource_group_name        = azurerm_resource_group.faas.name
  app_service_plan_id        = azurerm_app_service_plan.faas.id
  storage_account_name       = azurerm_storage_account.faas_storage.name
  storage_account_access_key = azurerm_storage_account.faas_storage.primary_access_key
  os_type                    = "linux"
  version                    = "~4"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
    "AzureWebJobsStorage" : azurerm_storage_account.faas_storage.primary_connection_string,
    "EVENT_GRID_TOPIC_ENDPOINT" : azurerm_eventgrid_topic.events.endpoint
    "EVENT_GRID_TOPIC_KEY" : azurerm_eventgrid_topic.events.primary_access_key
    "STORAGE_ACCOUNT_MESSAGES_TABLE_CONNECTION_STRING" : azurerm_storage_account.sa.primary_connection_string,
    "MESSAGES_TABLE_NAME" : azurerm_storage_table.messages.name,
    "MESSAGES_CONTAINER_NAME" : azurerm_storage_container.messages.name,
    "APPINSIGHTS_INSTRUMENTATIONKEY" : azurerm_application_insights.app_insights.instrumentation_key
  }
}