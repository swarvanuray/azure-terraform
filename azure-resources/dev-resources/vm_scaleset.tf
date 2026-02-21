# Data source to get the resource group
data "azurerm_resource_group" "vmss_rg" {
  name = "swarvanu"
}

# Use the subnet created by the network module
module "vm_scaleset" {
  source = "../dev-env-modules/vm_scaleset"

  rg_name          = data.azurerm_resource_group.vmss_rg.name
  location         = "East US"
  create_resource  = true
  vmss_name_prefix = "dev-vmss"
  vm_size          = "Standard_B2s"
  instances        = 2

  # Use db-subnet from the network module
  create_networking = false
  subnet_id = module.my_network.subnet_ids["db-subnet"]

  # Red Hat Enterprise Linux 9
  image_publisher = "RedHat"
  image_offer     = "RHEL"
  image_sku       = "9-lvm-gen2"
  image_version   = "latest"
}

output "vmss_id" {
  value = module.vm_scaleset.vmss_id
}

output "vmss_name" {
  value = module.vm_scaleset.vmss_name
}

output "vmss_password" {
  value     = module.vm_scaleset.admin_password
  sensitive = true
}
