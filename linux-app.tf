resource "azurerm_linux_web_app" "this" {
  count                         = var.os_type == "Linux" ? 1 : 0
  name                          = "${var.name}-${var.env}"
  resource_group_name           = var.resource_group_name
  location                      = azurerm_service_plan.this.location
  service_plan_id               = azurerm_service_plan.this.id
  app_settings                  = var.app_settings
  client_affinity_enabled       = var.enable_client_affinity
  https_only                    = var.https_only
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id     = var.enable_vnet_integration == true ? var.subnet_id : null

  tags = var.tags
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
    ip_restriction_default_action = var.ip_restriction_default_action == null ? "Deny" : var.ip_restriction_default_action
    ftps_state                    = var.ftps_state
    app_command_line              = var.app_command_line
    vnet_route_all_enabled        = var.enable_vnet_integration == true ? true : null
    dynamic "application_stack" {
      for_each = var.dotnet_stack ? [1] : []
      content {
        dotnet_version = var.dotnet_stack == true ? var.dotnet_version : null

      }
    }
    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        name                      = ip_restriction.value.name
        priority                  = ip_restriction.value.priority
        action                    = ip_restriction.value.action
        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id
        headers                   = ip_restriction.value.headers
        ip_address                = ip_restriction.value.ip_address
      }
    }
  }
}