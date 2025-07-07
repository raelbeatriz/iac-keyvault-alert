data "azurerm_resource_group" "resource-group" {
  name = local.rg_name
}

data "azurerm_key_vault" "key-vault" {
  name                = local.kv_name
  resource_group_name = local.rg_name
}

data "azurerm_log_analytics_workspace" "log-analytics" {
  name                = local.law_name
  resource_group_name = local.law_rg
}

resource "azurerm_monitor_action_group" "action-group" {
  name                = local.ag_name
  resource_group_name = local.law_rg
  short_name          = local.ag_short_name
  tags = local.tags
  dynamic "email_receiver" {
    for_each = local.email_addresses
    content {
      name = email_receiver.key
      email_address = email_receiver.value
  }
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic-setting" {
  name                       = local.ds_name
  target_resource_id         = data.azurerm_key_vault.key-vault.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-analytics.id
  enabled_log {
    category = "AuditEvent"
  }
  enabled_log {
    category = "AzurePolicyEvaluationDetails"
  }
  metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert-rule-secret" {
  name                      = local.ar_name_secret
  resource_group_name       = local.rg_name
  location                  = data.azurerm_resource_group.resource-group.location
  evaluation_frequency      = local.evaluation_frequency_secret
  window_duration           = local.window_duration_secret
  scopes                    = [data.azurerm_key_vault.key-vault.id]
  severity                  = local.severity_secret
  description               = local.description_secret
  display_name              = local.display_name_secret
  enabled                   = true
  skip_query_validation     = true
  tags = local.tags
  criteria {
    query                   = <<-QUERY
      AzureDiagnostics
        | where OperationName contains "SecretNearExpiry"
        | project SecretName = column_ifexists("eventGridEventProperties_data_ObjectName_s", "eventGridEventProperties_data_ObjectName_s")
      QUERY
    time_aggregation_method = "Count"
    threshold               = 1
    operator                = "GreaterThanOrEqual"

    dimension {
      name     = "SecretName"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }
  action {
    action_groups = [azurerm_monitor_action_group.action-group.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert-rule-key" {
  name                      = local.ar_name_key
  resource_group_name       = local.rg_name
  location                  = data.azurerm_resource_group.resource-group.location
  evaluation_frequency      = local.evaluation_frequency_key
  window_duration           = local.window_duration_key
  scopes                    = [data.azurerm_key_vault.key-vault.id]
  severity                  = local.severity_key
  description               = local.description_key
  display_name              = local.display_name_key
  enabled                   = true
  skip_query_validation     = true
  tags = local.tags
  criteria {
    query                   = <<-QUERY
      AzureDiagnostics
        | where OperationName contains "KeyNearExpiry"
        | project KeyName = column_ifexists("eventGridEventProperties_data_ObjectName_s", "eventGridEventProperties_data_ObjectName_s")
      QUERY
    time_aggregation_method = "Count"
    threshold               = 1
    operator                = "GreaterThanOrEqual"

    dimension {
      name     = "KeyName"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }
  action {
    action_groups = [azurerm_monitor_action_group.action-group.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert-rule-cert" {
  name                      = local.ar_name_cert
  resource_group_name       = local.rg_name
  location                  = data.azurerm_resource_group.resource-group.location
  evaluation_frequency      = local.evaluation_frequency_cert
  window_duration           = local.window_duration_cert
  scopes                    = [data.azurerm_key_vault.key-vault.id]
  severity                  = local.severity_cert
  description               = local.description_cert
  display_name              = local.display_name_cert
  enabled                   = true
  skip_query_validation     = true
  tags = local.tags
  criteria {
    query                   = <<-QUERY
      AzureDiagnostics
        | where OperationName contains "CertificateNearExpiry"
        | project CertificateName = column_ifexists("eventGridEventProperties_data_ObjectName_s", "eventGridEventProperties_data_ObjectName_s")
      QUERY
    time_aggregation_method = "Count"
    threshold               = 1
    operator                = "GreaterThanOrEqual"

    dimension {
      name     = "CertificateName"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }
  action {
    action_groups = [azurerm_monitor_action_group.action-group.id]
  }
}
