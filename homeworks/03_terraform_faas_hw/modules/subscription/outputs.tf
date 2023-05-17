output "events_to_table_subscription_id" {
  value     = azurerm_eventgrid_event_subscription.events_to_table.id
  sensitive = true
}

output "events_to_blob_subscription_id" {
  value     = azurerm_eventgrid_event_subscription.events_to_blob.id
  sensitive = true
}