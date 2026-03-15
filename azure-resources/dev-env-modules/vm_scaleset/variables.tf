# --- Feature Flag ---
variable "create_resource" {
  type        = bool
  default     = true
  description = "Feature flag to enable/disable VM Scale Set creation"
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

# --- VMSS Settings ---
variable "vmss_name_prefix" {
  type        = string
  default     = "vmss"
  description = "Name prefix for the VM Scale Set"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "Size (SKU) of the Virtual Machine instances"
}

variable "instances" {
  type        = number
  default     = 2
  description = "Number of VM instances in the scale set"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM instances"
}

# --- Networking ---
variable "create_networking" {
  type        = bool
  default     = true
  description = "Whether to create VNet/Subnet/NSG. Set to false when providing an existing subnet_id."
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "ID of an existing subnet to use. Required when create_networking is false."
}

variable "vnet_name" {
  type        = string
  default     = "vmss-vnet"
  description = "Name of the Virtual Network (ignored if subnet_id is set)"
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.2.0.0/16"]
  description = "Address space for the VNet (ignored if subnet_id is set)"
}

variable "subnet_name" {
  type        = string
  default     = "vmss-subnet"
  description = "Name of the Subnet (ignored if subnet_id is set)"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  default     = ["10.2.0.0/24"]
  description = "Address prefixes for the Subnet (ignored if subnet_id is set)"
}

# --- OS Image (RHEL 9 defaults) ---
variable "image_publisher" {
  type        = string
  default     = "RedHat"
  description = "Publisher of the OS image"
}

variable "image_offer" {
  type        = string
  default     = "RHEL"
  description = "Offer of the OS image"
}

variable "image_sku" {
  type        = string
  default     = "9-lvm-gen2"
  description = "SKU of the OS image"
}

variable "image_version" {
  type        = string
  default     = "latest"
  description = "Version of the OS image"
}
