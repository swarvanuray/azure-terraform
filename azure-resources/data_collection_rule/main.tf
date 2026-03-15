# 1. Create Data Collection Rule
resource "azurerm_monitor_data_collection_rule" "this" {
  count = var.create_resource ? 1 : 0

  name                        = var.rule_name
  resource_group_name         = var.rg_name
  location                    = var.location
  data_collection_endpoint_id = var.data_collection_endpoint_id
  description                 = var.description
  kind                        = var.kind

  # --- Destinations ---
  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = var.log_analytics_destination_name
    }

    dynamic "event_hub" {
      for_each = var.event_hub_destination != null ? [var.event_hub_destination] : []
      content {
        event_hub_id = event_hub.value.event_hub_id
        name         = event_hub.value.name
      }
    }

    dynamic "storage_blob" {
      for_each = var.storage_blob_destination != null ? [var.storage_blob_destination] : []
      content {
        storage_account_id = storage_blob.value.storage_account_id
        container_name     = storage_blob.value.container_name
        name               = storage_blob.value.name
      }
    }

    dynamic "azure_monitor_metrics" {
      for_each = var.enable_azure_monitor_metrics_destination ? [1] : []
      content {
        name = var.azure_monitor_metrics_destination_name
      }
    }

    dynamic "event_hub_direct" {
      for_each = var.event_hub_direct_destination != null ? [var.event_hub_direct_destination] : []
      content {
        event_hub_id = event_hub_direct.value.event_hub_id
        name         = event_hub_direct.value.name
      }
    }

    dynamic "storage_blob_direct" {
      for_each = var.storage_blob_direct_destination != null ? [var.storage_blob_direct_destination] : []
      content {
        storage_account_id = storage_blob_direct.value.storage_account_id
        container_name     = storage_blob_direct.value.container_name
        name               = storage_blob_direct.value.name
      }
    }

    dynamic "storage_table_direct" {
      for_each = var.storage_table_direct_destination != null ? [var.storage_table_direct_destination] : []
      content {
        table_name         = storage_table_direct.value.table_name
        storage_account_id = storage_table_direct.value.storage_account_id
        name               = storage_table_direct.value.name
      }
    }

    dynamic "monitor_account" {
      for_each = var.monitor_account_destination != null ? [var.monitor_account_destination] : []
      content {
        monitor_account_id = monitor_account.value.monitor_account_id
        name               = monitor_account.value.name
      }
    }
  }

  # --- Data Flows ---
  dynamic "data_flow" {
    for_each = var.data_flows
    content {
      streams            = data_flow.value.streams
      destinations       = data_flow.value.destinations
      built_in_transform = lookup(data_flow.value, "built_in_transform", null)
      output_stream      = lookup(data_flow.value, "output_stream", null)
      transform_kql      = lookup(data_flow.value, "transform_kql", null)
    }
  }

  # --- Data Sources ---
  data_sources {
    # Syslog (Linux)
    dynamic "syslog" {
      for_each = var.syslog_data_sources
      content {
        facility_names = syslog.value.facility_names
        log_levels     = syslog.value.log_levels
        name           = syslog.value.name
        streams        = syslog.value.streams
      }
    }

    # Performance Counters
    dynamic "performance_counter" {
      for_each = var.performance_counter_data_sources
      content {
        counter_specifiers            = performance_counter.value.counter_specifiers
        name                          = performance_counter.value.name
        sampling_frequency_in_seconds = performance_counter.value.sampling_frequency_in_seconds
        streams                       = performance_counter.value.streams
      }
    }

    # Windows Event Logs
    dynamic "windows_event_log" {
      for_each = var.windows_event_log_data_sources
      content {
        name           = windows_event_log.value.name
        streams        = windows_event_log.value.streams
        x_path_queries = windows_event_log.value.x_path_queries
      }
    }

    # IIS Logs
    dynamic "iis_log" {
      for_each = var.iis_log_data_sources
      content {
        name            = iis_log.value.name
        streams         = iis_log.value.streams
        log_directories = lookup(iis_log.value, "log_directories", null)
      }
    }

    # Log Files
    dynamic "log_file" {
      for_each = var.log_file_data_sources
      content {
        name          = log_file.value.name
        streams       = log_file.value.streams
        file_patterns = log_file.value.file_patterns
        format        = log_file.value.format

        dynamic "settings" {
          for_each = lookup(log_file.value, "settings", null) != null ? [log_file.value.settings] : []
          content {
            text {
              record_start_timestamp_format = settings.value.text.record_start_timestamp_format
            }
          }
        }
      }
    }

    # Extensions
    dynamic "extension" {
      for_each = var.extension_data_sources
      content {
        extension_name     = extension.value.extension_name
        name               = extension.value.name
        streams            = extension.value.streams
        extension_json     = lookup(extension.value, "extension_json", null)
        input_data_sources = lookup(extension.value, "input_data_sources", null)
      }
    }

    # Platform Telemetry
    dynamic "platform_telemetry" {
      for_each = var.platform_telemetry_data_sources
      content {
        name    = platform_telemetry.value.name
        streams = platform_telemetry.value.streams
      }
    }

    # Prometheus Forwarder
    dynamic "prometheus_forwarder" {
      for_each = var.prometheus_forwarder_data_sources
      content {
        name    = prometheus_forwarder.value.name
        streams = prometheus_forwarder.value.streams

        dynamic "label_include_filter" {
          for_each = lookup(prometheus_forwarder.value, "label_include_filter", [])
          content {
            label = label_include_filter.value.label
            value = label_include_filter.value.value
          }
        }
      }
    }

    # Windows Firewall Logs
    dynamic "windows_firewall_log" {
      for_each = var.windows_firewall_log_data_sources
      content {
        name    = windows_firewall_log.value.name
        streams = windows_firewall_log.value.streams
      }
    }

    # Data Import (Event Hub)
    dynamic "data_import" {
      for_each = var.data_import_event_hub != null ? [var.data_import_event_hub] : []
      content {
        event_hub_data_source {
          name           = data_import.value.name
          stream         = data_import.value.stream
          consumer_group = lookup(data_import.value, "consumer_group", null)
        }
      }
    }
  }

  # --- Stream Declarations ---
  dynamic "stream_declaration" {
    for_each = var.stream_declarations
    content {
      stream_name = stream_declaration.value.stream_name

      dynamic "column" {
        for_each = stream_declaration.value.columns
        content {
          name = column.value.name
          type = column.value.type
        }
      }
    }
  }

  # --- Identity ---
  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags
}

# 2. Associate the Data Collection Rule with VMs
resource "azurerm_monitor_data_collection_rule_association" "vm" {
  count = var.create_resource ? length(var.vm_ids) : 0

  name                    = "vm-dcr-assoc-${count.index}"
  target_resource_id      = var.vm_ids[count.index]
  data_collection_rule_id = azurerm_monitor_data_collection_rule.this[0].id
  description             = "Association between DCR and VM ${count.index}"
}

# 3. Associate the Data Collection Rule with VM Scale Sets
resource "azurerm_monitor_data_collection_rule_association" "vmss" {
  count = var.create_resource ? length(var.vmss_ids) : 0

  name                    = "vmss-dcr-assoc-${count.index}"
  target_resource_id      = var.vmss_ids[count.index]
  data_collection_rule_id = azurerm_monitor_data_collection_rule.this[0].id
  description             = "Association between DCR and VMSS ${count.index}"
}
