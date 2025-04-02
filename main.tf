resource "azurerm_service_plan" "this" {
  name                   = "${var.product}-asp-${var.name}-${var.env}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  os_type                = var.os_type
  sku_name               = var.sku_name
  zone_balancing_enabled = var.zone_redundant
  worker_count           = var.zone_redundant == true ? 3 : null
}

module "application_insights" {
  source = "github.com/moneyadviceservice/terraform-module-application-insights?ref=add_module"

  env                 = var.env
  product             = var.product
  name                = "${var.name}-${var.env}"
  resource_group_name = var.resource_group_name
}