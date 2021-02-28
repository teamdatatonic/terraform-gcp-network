variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "environment_prefix" {
  description = "The GCP envioment where the network will be created."
  type        = string

}

variable "firewall_custom_rules" {
  description = "map of custom rule definitions."
  type        = map(any)
  default     = {}
}

variable "network_name" {
  description = "The name of the network being created."
  type        = string
}

variable "delete_default_routes_on_create" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted,"
  default     = false
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')."
}

variable "subnets" {
  description = "The list of subnets to be created."
  type        = list(map(string))
  default     = []

}

variable "description" {
  description = "(Optional) An optional description of the VPC network. The resource must be recreated to modify this field."
  type        = string
  default     = null
}

variable "cloud_router_nat_config" {
  description = "map of objects to config cloud nat & router."
  type        = map(any)
  default     = {}
}

variable "region" {
  description = "(Optional) Region where the router and NAT reside."
  type        = string
  default     = null
}
