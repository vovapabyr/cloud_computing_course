output "azure_web_jobs_storage" {
  value     = azurerm_storage_account.faas_storage.primary_connection_string
  sensitive = true
}

output "events_topic_endpoint" {
  value     = azurerm_eventgrid_topic.events.endpoint
  sensitive = true
}

output "events_topic_key" {
  value     = azurerm_eventgrid_topic.events.primary_access_key
  sensitive = true
}

output "event_grid_topic_id" {
  value     = azurerm_eventgrid_topic.events.id
  sensitive = true
}

output "storage_account_connection_string" {
  value     = azurerm_storage_account.sa.primary_connection_string
  sensitive = true
}

output "storage_account_tablename" {
  value     = azurerm_storage_table.messages.name
  sensitive = true
}

output "storage_account_container" {
  value     = azurerm_storage_container.messages.name
  sensitive = true
}

output "azure_function_name" {
  value     = azurerm_function_app.faas.name
  sensitive = true
}

output "function_app_id" {
  value     = azurerm_function_app.faas.id
  sensitive = true
}