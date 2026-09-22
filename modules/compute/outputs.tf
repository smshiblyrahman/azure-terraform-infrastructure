output "vm_id" {
  value = azurerm_linux_virtual_machine.main.id
}

output "principal_id" {
  value = azurerm_linux_virtual_machine.main.identity[0].principal_id
}
