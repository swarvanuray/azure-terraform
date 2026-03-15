# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable managed disk creation and attachment"
}

# --- Required ---
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vm_ids" {
  type        = list(string)
  description = "List of Virtual Machine IDs to attach data disks to"
}

# --- Disk Configurations ---
variable "disk_configs" {
  type = list(object({
    name                 = string
    disk_size_gb         = number
    storage_account_type = string
  }))
  description = "List of disk configurations. Each entry creates one disk per VM with its own name, size, and storage account type."
  default = [
    {
      name                 = "data-disk"
      disk_size_gb         = 64
      storage_account_type = "Standard_LRS"
    }
  ]
}

# --- Attachment Settings ---
variable "caching" {
  type        = string
  default     = "ReadWrite"
  description = "Caching requirements for the data disk (None, ReadOnly, ReadWrite)"
}

variable "attach_create_option" {
  type        = string
  default     = "Attach"
  description = "The create option for the data disk attachment (Attach or Empty)"
}

variable "write_accelerator_enabled" {
  type        = bool
  default     = false
  description = "Enable Write Accelerator (only for Premium_LRS with no caching on M-Series VMs)"
}
