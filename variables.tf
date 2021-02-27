variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "environment_prefix" {
  description = "The GCP envioment where the network will be created."
  type        = string

}

variable "firewall_custom_rules" {
  description = "map of custom rule definitions"
  type        = map(any)
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "subnets" {
  description = "The list of subnets to be created."
  type        = list(map(string))

}

variable "description" {
  description = "(Optional) An optional description of the VPC network. The resource must be recreated to modify this field."
  type        = string
}

variable "cloud_router_nat_config" {
  description = "map of objects to config cloud nat & router"
  type        = map(any)
}

variable "region" {
  description = "(Optional) Region where the router and NAT reside."
  type        = string
}
