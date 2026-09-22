variable "vnet_name" {
  type        = string
  description = "Virtual network name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "VNet address space"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public subnet CIDR"
}

variable "application_subnet_cidr" {
  type        = string
  description = "Application subnet CIDR"
}

variable "database_subnet_cidr" {
  type        = string
  description = "Database subnet CIDR"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "enable_firewall" {
  type        = bool
  description = "Enable Azure Firewall"
  default     = false
}

variable "firewall_subnet_cidr" {
  type        = string
  description = "Firewall subnet CIDR"
  default     = ""
}

variable "private_dns_zone_name" {
  type        = string
  description = "Private DNS Zone name"
  default     = "privatelink.database.windows.net"
}
