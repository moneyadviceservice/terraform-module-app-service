module "staging_slot" {
  count = var.staging_slot_enabled ? 1 : 0

  source = "slots"

  environment = var.environment
  dotnet_stack = var.dotnet_stack

  slot_os_type = "Linux"
  name         = local.staging_slot_name
  id           = azurerm_linux_web_app.this[0].id

  public_network_access_enabled = var.public_network_access_enabled
  vnet_integration_subnet_id    = var.vnet_integration_subnet_id
  ip_restriction                = concat(local.subnets, local.cidrs, local.service_tags)
  scm_ip_restriction            = concat(local.scm_subnets, local.scm_cidrs, local.scm_service_tags)
  scm_allowed_cidrs             = var.scm_allowed_cidrs
  scm_allowed_subnet_ids        = var.scm_allowed_subnet_ids

  site_config                    = local.slot_site_config
  app_settings                   = var.staging_slot_custom_app_settings == null ? local.app_settings : merge(local.default_app_settings, var.staging_slot_custom_app_settings)
  connection_strings             = var.connection_strings
  auth_settings                  = local.auth_settings
  auth_settings_active_directory = local.auth_settings_active_directory
  auth_settings_v2               = local.auth_settings_v2
  auth_settings_v2_login         = local.auth_settings_v2_login

  client_affinity_enabled = var.client_affinity_enabled
  https_only              = var.https_only
  logs                    = var.logs
}
