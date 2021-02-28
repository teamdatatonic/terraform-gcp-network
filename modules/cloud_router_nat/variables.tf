variable "project_id" {
  description = "The ID of the project where this firewall rule will be created"
}

variable "environment_prefix" {
  description = "The GCP envioment where the router nat will be created."
  type        = string
}

variable "network_name" {
  description = "The name of the vpc network."
  type        = string
}


variable "router_name" {
  description = "The name of the router."
  type        = string
}

variable "asn" {
  description = "(Required) Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit."
  type        = number
}

variable "nats" {
  description = "One or more NAT services created in a router."
  type        = map(any)
}

variable "region" {
  description = "Region where the router and NAT reside."
  type        = string
}
