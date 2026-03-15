# 1. Create Virtual Network
resource "azurerm_virtual_network" "vm_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
}

# 2. Create Subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# 2.1 Create Network Security Group
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${var.vm_name_prefix}-nsg"
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

# 2.2 Associate NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "vm_nsg_assoc" {
  subnet_id                 = azurerm_subnet.vm_subnet.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

# 2.3 Create Public IP (using count)
resource "azurerm_public_ip" "vm_pip" {
  count = var.vm_count

  name                = "${var.vm_name_prefix}-pip-${count.index}"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}


# 3. Create Network Interface (using count)
resource "azurerm_network_interface" "vm_nic" {
  count = var.vm_count

  name                = "${var.vm_name_prefix}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip[count.index].id
  }
}

# Generate a random password
resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# 4. Create Linux Virtual Machine (using count)
resource "azurerm_linux_virtual_machine" "vm" {
  count = var.vm_count

  name                = "${var.vm_name_prefix}-${count.index}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = "azureuser"
  admin_password      = random_password.vm_password.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.vm_nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

# 5. Install Azure Monitor Agent (AMA) Extension on each VM
resource "azurerm_virtual_machine_extension" "ama" {
  count = var.install_ama_agent ? var.vm_count : 0

  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.33"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true

  tags = {
    CreatedBy = "Terraform"
    Module    = "VM-AMA"
  }
}
