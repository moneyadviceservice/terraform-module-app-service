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

output "system_assigned_identity_object_id" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_web_app.this[0].identity[0].principal_id : azurerm_linux_web_app.this[0].identity[0].principal_id
}

output "asp_id" {
  value = length(azurerm_service_plan.this) > 0 ? azurerm_service_plan.this[0].id : var.app_service_plan_id
}
