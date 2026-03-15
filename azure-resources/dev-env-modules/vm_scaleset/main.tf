# Determine the subnet ID to use:
# - If an existing subnet_id is provided, use it (skip creating networking)
# - Otherwise, create VNet/Subnet/NSG
locals {
  should_create_networking = var.create_resource && var.create_networking
  effective_subnet_id = var.create_networking ? (
    local.should_create_networking ? azurerm_subnet.vmss_subnet[0].id : null
  ) : var.subnet_id
}

# 1. Create Virtual Network (only if no existing subnet_id provided)
resource "azurerm_virtual_network" "vmss_vnet" {
  count = local.should_create_networking ? 1 : 0

  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
}

# 2. Create Subnet (only if no existing subnet_id provided)
resource "azurerm_subnet" "vmss_subnet" {
  count = local.should_create_networking ? 1 : 0

  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vmss_vnet[0].name
  address_prefixes     = var.subnet_address_prefixes
}

# 3. Create Network Security Group (only if no existing subnet_id provided)
resource "azurerm_network_security_group" "vmss_nsg" {
  count = local.should_create_networking ? 1 : 0

  name                = "${var.vmss_name_prefix}-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# 4. Associate NSG with Subnet (only if no existing subnet_id provided)
resource "azurerm_subnet_network_security_group_association" "vmss_nsg_assoc" {
  count = local.should_create_networking ? 1 : 0

  subnet_id                 = azurerm_subnet.vmss_subnet[0].id
  network_security_group_id = azurerm_network_security_group.vmss_nsg[0].id
}

# 5. Generate a random password
resource "random_password" "vmss_password" {
  count = var.create_resource ? 1 : 0

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# 6. Create Linux Virtual Machine Scale Set
resource "azurerm_linux_virtual_machine_scale_set" "this" {
  count = var.create_resource ? 1 : 0

  name                = var.vmss_name_prefix
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.vm_size
  instances           = var.instances
  admin_username      = var.admin_username
  admin_password      = random_password.vmss_password[0].result
  upgrade_mode        = "Automatic"

  disable_password_authentication = false

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "${var.vmss_name_prefix}-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = local.effective_subnet_id
    }
  }

  tags = {
    CreatedBy = "Terraform"
    Module    = "VMScaleSet"
  }
}
