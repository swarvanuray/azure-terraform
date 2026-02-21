# Data source to get the resource group
data "azurerm_resource_group" "vm_rg" {
  name = "swarvanu"
}

module "vm_machines" {
  source = "../dev-env-modules/vm"

  rg_name        = data.azurerm_resource_group.vm_rg.name
  location       = "East US"
  vm_count       = 2
  vm_name_prefix = "dev-vm"
  vm_size        = "Standard_B2s"


  # Network settings (optional, defaults are used if not specified)
  vnet_name               = "dev-vnet"
  vnet_address_space      = ["10.1.0.0/16"]
  subnet_name             = "default"
  subnet_address_prefixes = ["10.1.0.0/24"]

  # Red Hat Enterprise Linux 9
  image_publisher = "RedHat"
  image_offer     = "RHEL"
  image_sku       = "9-lvm-gen2"
  image_version   = "latest"

  # Install Azure Monitor Agent for log collection
  install_ama_agent = true
}

output "vm_ids" {
  value = module.vm_machines.vm_ids
}

output "vm_private_ips" {
  value = module.vm_machines.vm_private_ips
}

output "vm_password" {
  value     = module.vm_machines.admin_password
  sensitive = true
}

output "vm_public_ips" {
  value = module.vm_machines.vm_public_ips
}
