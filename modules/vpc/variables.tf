variable "project_id" {
  description = "The ID of the project where this VPC will be created."
}

variable "network_name" {
  description = "The name of the network being created."
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')."
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "delete_default_routes_on_create" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted,"
  default     = true
}

variable "mtu" {
  type        = number
  description = "The network MTU (default '1460'). Must be a value between 1460 and 1500 inclusive."
  default     = 1460

}

variable "environment_prefix" {
  description = "The GCP envioment where the vpc will be created."
  type        = string
}

variable "default_internet_gateway" {
  type        = bool
  description = "If True, sets up the 0.0.0.0/0 next hop internet gateway"
  default     = false
}
