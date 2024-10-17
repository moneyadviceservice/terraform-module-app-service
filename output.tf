output "instrumentation_key" {
  value = module.application_insights.azurerm_application_insights.this.instrumentation_key
}
output "app_service_id" {
  value = lower(var.os_type) == "windows" ? data.azurerm_windows_web_app.this[0].id : data.azurerm_linux_web_app.this[0].id
}

output "app_service_name" {
  value = lower(var.os_type) == "windows" ? data.azurerm_windows_web_app.this[0].name : data.azurerm_linux_web_app.this[0].name
}