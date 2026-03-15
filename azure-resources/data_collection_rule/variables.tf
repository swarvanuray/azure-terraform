# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable Data Collection Rule creation"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the Data Collection Rule"
}

variable "rule_name" {
  type        = string
  description = "Name of the Data Collection Rule"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The resource ID of the Log Analytics Workspace destination"
}

# --- Optional Top-Level ---
variable "data_collection_endpoint_id" {
  type        = string
  default     = null
  description = "The resource ID of the Data Collection Endpoint that this rule can be used with"
}

variable "description" {
  type        = string
  default     = null
  description = "The description of the Data Collection Rule"
}

variable "kind" {
  type        = string
  default     = null
  description = "The kind of the Data Collection Rule. Possible values: Linux, Windows, AgentDirectToStore, WorkspaceTransforms"
}

# --- Destination Settings ---
variable "log_analytics_destination_name" {
  type        = string
  default     = "log-analytics-destination"
  description = "Name for the Log Analytics destination (must be unique within the rule)"
}

variable "enable_azure_monitor_metrics_destination" {
  type        = bool
  default     = false
  description = "Enable Azure Monitor Metrics as a destination"
}

variable "azure_monitor_metrics_destination_name" {
  type        = string
  default     = "azure-monitor-metrics-destination"
  description = "Name for the Azure Monitor Metrics destination"
}

variable "event_hub_destination" {
  type = object({
    event_hub_id = string
    name         = string
  })
  default     = null
  description = "Event Hub destination configuration"
}

variable "event_hub_direct_destination" {
  type = object({
    event_hub_id = string
    name         = string
  })
  default     = null
  description = "Event Hub Direct destination (only for AgentDirectToStore kind)"
}

variable "storage_blob_destination" {
  type = object({
    storage_account_id = string
    container_name     = string
    name               = string
  })
  default     = null
  description = "Storage Blob destination configuration"
}

variable "storage_blob_direct_destination" {
  type = object({
    storage_account_id = string
    container_name     = string
    name               = string
  })
  default     = null
  description = "Storage Blob Direct destination (only for AgentDirectToStore kind)"
}

variable "storage_table_direct_destination" {
  type = object({
    table_name         = string
    storage_account_id = string
    name               = string
  })
  default     = null
  description = "Storage Table Direct destination (only for AgentDirectToStore kind)"
}

variable "monitor_account_destination" {
  type = object({
    monitor_account_id = string
    name               = string
  })
  default     = null
  description = "Monitor Account destination configuration"
}

# --- Data Flows ---
variable "data_flows" {
  type = list(object({
    streams            = list(string)
    destinations       = list(string)
    built_in_transform = optional(string)
    output_stream      = optional(string)
    transform_kql      = optional(string)
  }))
  description = "List of data flow configurations routing streams to destinations"
}

# --- Data Sources ---
variable "syslog_data_sources" {
  type = list(object({
    facility_names = list(string)
    log_levels     = list(string)
    name           = string
    streams        = list(string)
  }))
  default     = []
  description = "Syslog data source configurations (Linux)"
}

variable "performance_counter_data_sources" {
  type = list(object({
    counter_specifiers            = list(string)
    name                          = string
    sampling_frequency_in_seconds = number
    streams                       = list(string)
  }))
  default     = []
  description = "Performance counter data source configurations"
}

variable "windows_event_log_data_sources" {
  type = list(object({
    name           = string
    streams        = list(string)
    x_path_queries = list(string)
  }))
  default     = []
  description = "Windows Event Log data source configurations"
}

variable "iis_log_data_sources" {
  type = list(object({
    name            = string
    streams         = list(string)
    log_directories = optional(list(string))
  }))
  default     = []
  description = "IIS Log data source configurations"
}

variable "log_file_data_sources" {
  type = list(object({
    name          = string
    streams       = list(string)
    file_patterns = list(string)
    format        = string
    settings = optional(object({
      text = object({
        record_start_timestamp_format = string
      })
    }))
  }))
  default     = []
  description = "Log File data source configurations"
}

variable "extension_data_sources" {
  type = list(object({
    extension_name     = string
    name               = string
    streams            = list(string)
    extension_json     = optional(string)
    input_data_sources = optional(list(string))
  }))
  default     = []
  description = "Extension data source configurations"
}

variable "platform_telemetry_data_sources" {
  type = list(object({
    name    = string
    streams = list(string)
  }))
  default     = []
  description = "Platform Telemetry data source configurations"
}

variable "prometheus_forwarder_data_sources" {
  type = list(object({
    name    = string
    streams = list(string)
    label_include_filter = optional(list(object({
      label = string
      value = string
    })), [])
  }))
  default     = []
  description = "Prometheus Forwarder data source configurations"
}

variable "windows_firewall_log_data_sources" {
  type = list(object({
    name    = string
    streams = list(string)
  }))
  default     = []
  description = "Windows Firewall Log data source configurations"
}

variable "data_import_event_hub" {
  type = object({
    name           = string
    stream         = string
    consumer_group = optional(string)
  })
  default     = null
  description = "Data Import Event Hub data source configuration"
}

# --- Stream Declarations ---
variable "stream_declarations" {
  type = list(object({
    stream_name = string
    columns = list(object({
      name = string
      type = string
    }))
  }))
  default     = []
  description = "Custom stream declarations (stream_name must begin with 'Custom-')"
}

# --- Identity ---
variable "identity_type" {
  type        = string
  default     = null
  description = "Specifies the identity type. Possible values: SystemAssigned, UserAssigned"
}

variable "identity_ids" {
  type        = list(string)
  default     = null
  description = "A list of user managed identity IDs. Required if identity_type is UserAssigned"
}

# --- Resource Associations ---
variable "vm_ids" {
  type        = list(string)
  default     = []
  description = "List of VM resource IDs to associate with the Data Collection Rule"
}

variable "vmss_ids" {
  type        = list(string)
  default     = []
  description = "List of VM Scale Set resource IDs to associate with the Data Collection Rule"
}

# --- Tags ---
variable "tags" {
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
    Module    = "DataCollectionRule"
  }
  description = "A mapping of tags to assign to the resource"
}
