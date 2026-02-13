resource "azurerm_service_plan" "this" {
<<<<<<< HEAD
  count               = var.create_service_plan ? 1 : 0
  name                = var.asp_name != null ? var.asp_name : "${var.product}-asp-${var.name}-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name
=======
  name                   = "${var.product}-asp-${var.name}-${var.env}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  os_type                = var.os_type
  sku_name               = var.sku_name
  zone_balancing_enabled = var.zone_redundant
  worker_count           = var.zone_redundant == true ? 3 : null
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649
}

module "application_insights" {
  source = "github.com/moneyadviceservice/terraform-module-application-insights?ref=main"

  env                 = var.env
  product             = var.product
  name                = "${var.name}-${var.env}"
  resource_group_name = var.resource_group_name
  retention_in_days   = var.log_retention_days
}