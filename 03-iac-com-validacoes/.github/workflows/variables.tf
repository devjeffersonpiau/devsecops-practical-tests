variable "project" {
  description = "Prefixo do projeto para nomear recursos"
  type        = string
  default     = "devopsdemo"
}

variable "location" {
  description = "Região do Azure"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
  default     = "rg-devopsdemo"
}

variable "vm_size" {
  description = "SKU da VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Usuário admin da VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Caminho para sua chave pública SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Storage / Blob
variable "container_name" {
  description = "Nome do container de blobs"
  type        = string
  default     = "uploads"
}

variable "blob_name" {
  description = "Nome do blob a ser criado"
  type        = string
  default     = "exemplo.jpg"
}

variable "local_upload_path" {
  description = "Caminho local do arquivo a enviar para o blob"
  type        = string
  default     = "./uploads/exemplo.jpg"
}

variable "blob_content_type" {
  description = "Content-Type do blob"
  type        = string
  default     = "image/jpeg"
}

variable "public_read" {
  description = "Se true, container fica com leitura pública de blobs"
  type        = bool
  default     = true
}