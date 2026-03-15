# --- Feature Flags ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable Azure File Share creation"
}

variable "create_share_file" {
  type        = bool
  default     = false
  description = "Feature flag to enable/disable file creation inside the Azure File Share"
}

# --- Required for File Share ---
variable "storage_account_name" {
  type        = string
  description = "Storage account name where the file share is created"
}

variable "share_name" {
  type        = string
  description = "Name of the Azure File Share"
}

# --- Optional File Share Settings ---
variable "quota" {
  type        = number
  default     = 100
  description = "File share quota in GB"
}

variable "enabled_protocol" {
  type        = string
  default     = "SMB"
  description = "Protocol for the file share (SMB or NFS)"
}

# --- Optional File Upload Settings ---
variable "file_name" {
  type        = string
  default     = "linux-init.txt"
  description = "Name of the file to upload to the file share"
}

variable "source_file" {
  type        = string
  default     = ""
  description = "Local source file path to upload when create_share_file is true"
}

variable "file_path" {
  type        = string
  default     = ""
  description = "Optional virtual directory path inside the file share"
}

variable "file_content_type" {
  type        = string
  default     = "text/plain"
  description = "Content type of the uploaded file"
}
