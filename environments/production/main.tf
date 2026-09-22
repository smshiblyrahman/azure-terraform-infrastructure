locals {
  environment = "production"
  location    = "eastus"
  prefix      = "selise-demo-${local.environment}"
  tags = {
    environment = local.environment
    project     = "selise-demo"
    managed-by  = "terraform"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = local.location
  tags     = local.tags
}

module "networking" {
  source = "../../modules/networking"

  vnet_name               = "${local.prefix}-vnet"
  location                = azurerm_resource_group.main.location
  resource_group_name     = azurerm_resource_group.main.name
  vnet_address_space      = ["10.2.0.0/16"]
  public_subnet_cidr      = "10.2.1.0/24"
  application_subnet_cidr = "10.2.2.0/24"
  database_subnet_cidr    = "10.2.3.0/24"
  enable_firewall         = true
  firewall_subnet_cidr    = "10.2.4.0/24"
  tags                    = local.tags
}

module "storage" {
  source = "../../modules/storage"

  storage_account_name = replace("${local.prefix}sa", "-", "")
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  tags                 = local.tags
}

module "compute" {
  source = "../../modules/compute"

  vm_name             = "${local.prefix}-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.networking.application_subnet_id
  admin_username      = "adminuser"
  admin_public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC..."
  enable_lb           = true
  tags                = local.tags
}

module "security" {
  source = "../../modules/security"

  key_vault_name             = "${local.prefix}-kv"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  vm_principal_id            = module.compute.principal_id
  storage_account_id         = module.storage.storage_account_id
  enable_private_endpoints   = true
  private_endpoint_subnet_id = module.networking.application_subnet_id
  tags                       = local.tags
}
