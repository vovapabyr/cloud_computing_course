output "azure_web_jobs_storage" {
  value     = module.main.azure_web_jobs_storage
  sensitive = true
}

output "events_topic_endpoint" {
  value     = module.main.events_topic_endpoint
  sensitive = true
}

output "events_topic_key" {
  value     = module.main.events_topic_key
  sensitive = true
}

output "storage_account_connection_string" {
  value     = module.main.storage_account_connection_string
  sensitive = true
}

output "storage_account_tablename" {
  value     = module.main.storage_account_tablename
  sensitive = true
}

output "storage_account_container" {
  value     = module.main.storage_account_container
  sensitive = true
}

output "storage_account_blob" {
  value     = module.main.storage_account_blob
  sensitive = true
}

output "azure_function_name" {
  value     = module.main.azure_function_name
  sensitive = true
}

output "events_subscription_id" {
  value     = module.subscription.events_subscription_id
  sensitive = true
}