resource "azurerm_service_plan" "this" {
  count               = var.app_service_plan_id == null ? 1 : 0
  name                = var.asp_name != null ? var.asp_name : "${var.product}-asp-${var.name}-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

module "application_insights" {
  source = "github.com/moneyadviceservice/terraform-module-application-insights?ref=add_module"

  env                 = var.env
  product             = var.product
  name                = "${var.name}-${var.env}"
  resource_group_name = var.resource_group_name
}