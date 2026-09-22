variable "vm_name" {
  type        = string
  description = "Virtual machine name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for NIC"
}

variable "vm_size" {
  type        = string
  description = "VM Size"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username"
}

variable "admin_public_key" {
  type        = string
  description = "SSH public key"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "enable_lb" {
  type        = bool
  description = "Enable Load Balancer"
  default     = false
}
