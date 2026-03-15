# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable EventHub creation"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "eventhub_name" {
  type        = string
  description = "Name of the EventHub"
}

variable "namespace_name" {
  type        = string
  description = "Name of the EventHub Namespace where this EventHub will be created"
}

variable "partition_count" {
  type        = number
  default     = 2
  description = "Number of partitions for the EventHub. Cannot be decreased. Max 32 for shared namespace, 1024 for dedicated cluster"
}

variable "message_retention" {
  type        = number
  default     = 1
  description = "Number of days to retain events. Max 7 for Standard SKU, 1 for Basic SKU, 90 for dedicated cluster"
}

# --- Optional ---
variable "status" {
  type        = string
  default     = "Active"
  description = "Status of the EventHub. Possible values: Active, Disabled, SendDisabled"
}

# --- Capture Description (Optional) ---
variable "capture_enabled" {
  type        = bool
  default     = false
  description = "Enable the EventHub Capture feature"
}

variable "capture_encoding" {
  type        = string
  default     = "Avro"
  description = "Encoding for the Capture Description. Possible values: Avro, AvroDeflate"
}

variable "capture_interval_in_seconds" {
  type        = number
  default     = 300
  description = "Time interval in seconds at which the capture will happen (60-900)"
}

variable "capture_size_limit_in_bytes" {
  type        = number
  default     = 314572800
  description = "Amount of data built up before a Capture Operation occurs (10485760-524288000)"
}

variable "capture_skip_empty_archives" {
  type        = bool
  default     = false
  description = "Should empty files not be emitted if no events occur during the Capture time window?"
}

variable "capture_destination_name" {
  type        = string
  default     = "EventHubArchive.AzureBlockBlob"
  description = "Name of the capture destination"
}

variable "capture_blob_container_name" {
  type        = string
  default     = null
  description = "Name of the Blob Container to capture to"
}

variable "capture_storage_account_id" {
  type        = string
  default     = null
  description = "ID of the Storage Account where captured data will be stored"
}

variable "capture_archive_name_format" {
  type        = string
  default     = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
  description = "Naming format for the captured files"
}
