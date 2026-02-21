module "data_collection_rule" {
  source = "../data_collection_rule"

  rg_name                    = data.azurerm_resource_group.existing_rg.name
  location                   = data.azurerm_resource_group.existing_rg.location
  rule_name                  = "swarvanu-dcr"
  log_analytics_workspace_id = module.log_analytics.workspace_id
  kind                       = "Linux"
  description                = "Data Collection Rule for VMs and VMSS - sends logs to Log Analytics Workspace"

  # Associate with VMs and VM Scale Sets
  vm_ids   = module.vm_machines.vm_ids
  vmss_ids = [module.vm_scaleset.vmss_id]

  # --- Data Sources ---

  # Syslog (Linux system logs)
  syslog_data_sources = [
    {
      facility_names = ["*"]
      log_levels     = ["*"]
      name           = "syslog-datasource"
      streams        = ["Microsoft-Syslog"]
    }
  ]

  # Performance counters (CPU, Memory, Disk, Network)
  performance_counter_data_sources = [
    {
      counter_specifiers = [
        "Processor(*)\\% Processor Time",
        "Memory(*)\\% Used Memory",
        "LogicalDisk(*)\\% Free Space",
        "Network(*)\\Total Bytes Transmitted",
        "Network(*)\\Total Bytes Received"
      ]
      name                          = "perf-counter-datasource"
      sampling_frequency_in_seconds = 60
      streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
    }
  ]

  # --- Data Flows (route all streams to Log Analytics) ---
  data_flows = [
    {
      streams      = ["Microsoft-Syslog"]
      destinations = ["log-analytics-destination"]
    },
    {
      streams      = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
      destinations = ["log-analytics-destination"]
    }
  ]
}

output "data_collection_rule_id" {
  value = module.data_collection_rule.data_collection_rule_id
}

output "data_collection_rule_name" {
  value = module.data_collection_rule.data_collection_rule_name
}
