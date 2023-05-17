resource "azurerm_eventgrid_event_subscription" "events_to_table" {
  name  = "events-to-table-subscription"
  scope = var.event_grid_topic_id

  azure_function_endpoint {
    function_id          = "${var.function_app_id}/functions/EventGridToTable"
    max_events_per_batch = 1
  }

  retry_policy {
    max_delivery_attempts = 3
    event_time_to_live    = 60
  }
}

resource "azurerm_eventgrid_event_subscription" "events_to_blob" {
  name  = "events-to-blob-subscription"
  scope = var.event_grid_topic_id

  azure_function_endpoint {
    function_id          = "${var.function_app_id}/functions/EventGridToBlob"
    max_events_per_batch = 1
  }

  retry_policy {
    max_delivery_attempts = 3
    event_time_to_live    = 60
  }
}

