resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_public_ip" "lb" {
  count               = var.enable_lb ? 1 : 0
  name                = "${var.vm_name}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_lb" "main" {
  count               = var.enable_lb ? 1 : 0
  name                = "${var.vm_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb[0].id
  }
  
  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "main" {
  count           = var.enable_lb ? 1 : 0
  loadbalancer_id = azurerm_lb.main[0].id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count                   = var.enable_lb ? 1 : 0
  network_interface_id    = azurerm_network_interface.main.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main[0].id
}

resource "azurerm_lb_probe" "http" {
  count           = var.enable_lb ? 1 : 0
  loadbalancer_id = azurerm_lb.main[0].id
  name            = "http-probe"
  port            = 80
}
