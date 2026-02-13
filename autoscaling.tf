resource "azurerm_monitor_autoscale_setting" "scale_out" {
<<<<<<< HEAD
  count               = var.create_service_plan == true ? 1 : 0
  name                = azurerm_service_plan.this[count.index].name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_service_plan.this[count.index].id
=======
  name                = azurerm_service_plan.this.name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_service_plan.this.id
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649

  profile {
    name = "Scale out condition"
    capacity {
<<<<<<< HEAD
      default = 1
      minimum = 1
      maximum = 5
=======
      default = 2
      minimum = 2
      maximum = 30
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
<<<<<<< HEAD
        metric_resource_id = azurerm_service_plan.this[count.index].id
=======
        metric_resource_id = azurerm_service_plan.this.id
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 60
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
<<<<<<< HEAD
        metric_resource_id = azurerm_service_plan.this[count.index].id
=======
        metric_resource_id = azurerm_service_plan.this.id
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 40
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT2M"
      }
    }
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 628fc2280857197d9a4add4dd6e8c71a000a2649
