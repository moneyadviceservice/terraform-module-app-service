output "instrumentation_key" {
  value = module.application_insights.instrumentation_key
}

output "app_insights_app_id" {
  value = module.application_insights.app_id
}
output "app_service_id" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_web_app.this[0].id : azurerm_linux_web_app.this[0].id
}

output "app_service_name" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_web_app.this[0].name : azurerm_linux_web_app.this[0].name
}