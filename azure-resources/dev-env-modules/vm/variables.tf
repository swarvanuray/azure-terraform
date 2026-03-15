variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_name_prefix" {
  description = "Prefix for the VM names"
  type        = string
  default     = "vm"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "vm-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "vm-subnet"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the Subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "image_publisher" {
  description = "Publisher of the OS image"
  type        = string
  default     = "RedHat"
}

variable "image_offer" {
  description = "Offer of the OS image"
  type        = string
  default     = "RHEL"
}

variable "image_sku" {
  description = "SKU of the OS image"
  type        = string
  default     = "9-lvm-gen2"
}

variable "image_version" {
  description = "Version of the OS image"
  type        = string
  default     = "latest"
}

# --- Azure Monitor Agent ---
variable "install_ama_agent" {
  type        = bool
  default     = false
  description = "Whether to install the Azure Monitor Agent (AMA) extension on each VM"
}
