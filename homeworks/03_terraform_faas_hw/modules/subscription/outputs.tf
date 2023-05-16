output "events_subscription_id" {
  value     = azurerm_eventgrid_event_subscription.events.id
  sensitive = true
}