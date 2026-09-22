output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "application_subnet_id" {
  value = azurerm_subnet.application.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database.id
}
