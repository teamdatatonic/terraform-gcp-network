variable "project_id" {
  description = "The ID of the project where this VPC will be created."
  type        = string
}

variable "network_name" {
  description = "The name of the vpc network."
  type        = string
}

variable "subnets" {
  description = "The list of subnets to be created."
  type        = list(map(string))
}


variable "environment_prefix" {
  description = "The GCP envioment where the subnets will be created."
  type        = string
}

variable "default_region" {
  description = "Allows a default region to be passed in"
  type        = string
  default     = ""
}
