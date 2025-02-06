resource "azurerm_service_plan" "this" {
  name                = "${var.product}-asp-${var.name}-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "this" {
  count                   = var.os_type == "Linux" ? 1 : 0
  name                    = "${var.name}-${var.env}"
  resource_group_name     = var.resource_group_name
  location                = azurerm_service_plan.this.location
  service_plan_id         = azurerm_service_plan.this.id
  app_settings            = var.app_settings
  client_affinity_enabled = var.enable_client_affinity
  https_only              = var.https_only
  tags                    = var.tags
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
    ftps_state       = var.ftps_state
    app_command_line = var.app_command_line
    dynamic "application_stack" {
      for_each = var.dotnet_stack ? [1] : []
      content {
        dotnet_version = var.dotnet_stack == true ? var.dotnet_version : null

      }
    }
  }
}

resource "azurerm_windows_web_app" "this" {
  count                   = var.os_type == "Windows" ? 1 : 0
  name                    = "${var.name}-${var.env}"
  resource_group_name     = var.resource_group_name
  location                = azurerm_service_plan.this.location
  service_plan_id         = azurerm_service_plan.this.id
  app_settings            = var.app_settings
  client_affinity_enabled = var.enable_client_affinity
  https_only              = var.https_only
  tags                    = var.tags
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
    dynamic "application_stack" {
      for_each = var.dotnet_stack ? [1] : []
      content {
        dotnet_version = var.dotnet_stack == true ? var.dotnet_version : null

      }
    }
    ftps_state = var.ftps_state
  }
}

module "application_insights" {
  source = "github.com/moneyadviceservice/terraform-module-application-insights?ref=add_module"

  env                 = var.env
  product             = var.product
  name                = "${var.name}-${var.env}"
  resource_group_name = var.resource_group_name
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet-integration" {
  count = var.enable_vnet_integration == true ? 1 : 0

  app_service_id = azurerm_windows_function_app.this.id
  subnet_id      = var.subnet_id
}