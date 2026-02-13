
resource "azurerm_windows_web_app" "this" {
  count                         = var.os_type == "Windows" ? 1 : 0
  name                          = "${var.name}-${var.env}"
  resource_group_name           = var.resource_group_name
<<<<<<< HEAD
  location                      = var.location
  service_plan_id               = var.create_service_plan == true ? azurerm_service_plan.this[count.index].id : var.service_plan_id
=======
  location                      = azurerm_service_plan.this.location
  service_plan_id               = azurerm_service_plan.this.id
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649
  app_settings                  = var.app_settings
  client_affinity_enabled       = var.enable_client_affinity
  https_only                    = var.https_only
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.enable_vnet_integration == true ? var.subnet_id : null
  tags                          = var.tags
  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }
  identity {
    type = "SystemAssigned"
  }
  site_config {
<<<<<<< HEAD
=======
    ip_restriction_default_action = var.ip_restriction_default_action == null ? "Deny" : var.ip_restriction_default_action
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649
    dynamic "application_stack" {
      for_each = var.dotnet_stack ? [1] : []
      content {
        dotnet_version = var.dotnet_stack == true ? var.dotnet_version : null

      }
    }
    ftps_state = var.ftps_state
  }
}