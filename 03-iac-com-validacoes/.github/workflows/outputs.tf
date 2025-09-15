output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "IP público da VM"
}

output "storage_account_name" {
  value       = azurerm_storage_account.sa.name
  description = "Nome do Storage Account"
}

output "blob_url" {
  value       = azurerm_storage_blob.blob.url
  description = "URL do blob (se container for público, pode acessar direto)"
}