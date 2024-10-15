resource "azurerm_service_plan" "this" {
  name                = "${var.product}-asp-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "this" {
  count               = var.os_type == "Linux" ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = azurerm_service_plan.this.location
  service_plan_id     = azurerm_service_plan.this.id
  app_settings        = var.app_settings
  tags                = var.tags
  identity {
    type = SystemAssigned
  }
  site_config {
    application_stack {}
  }
}

resource "azurerm_windows_web_app" "this" {
  count               = var.os_type == "Windows" ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = azurerm_service_plan.this.location
  service_plan_id     = azurerm_service_plan.this.id
  app_settings        = var.app_settings
  tags                = var.tags
  identity {
    type = SystemAssigned
  }
  site_config {
    application_stack {}
  }
}

module "application_insights" {
  source = "github.com/moneyadviceservice/terraform-module-application-insights?ref=add_module"

  env                 = var.env
  product             = var.product
  name                = var.name
  resource_group_name = var.resource_group_name
}