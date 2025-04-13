variable "auto_create_subnetworks" {
  description = "Whether to autocreate subnets or not"
  default     = false
  type        = bool
}

variable "network_description" {
  description = "Network description"
  default     = "Custom network"
  type        = string
}

variable "network_name" {
  description = "Network name"
  default     = "custom"
  type        = string
}

variable "subnets" {
  type        = map(any)
  description = "Map of subnets to create"
}
