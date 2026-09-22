variable "key_vault_name" {
  type        = string
  description = "Key Vault name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "vm_principal_id" {
  type        = string
  description = "Principal ID of VM for access policy"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "storage_account_id" {
  type        = string
  description = "Storage account ID for RBAC"
  default     = ""
}

variable "enable_private_endpoints" {
  type        = bool
  description = "Enable Private Endpoints"
  default     = false
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Subnet ID for Private Endpoints"
  default     = ""
}
