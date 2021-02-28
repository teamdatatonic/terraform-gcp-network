variable "project_id" {
  description = "The ID of the project where this firewall rule will be created."
}

variable "firewall_custom_rules" {
  description = "List of custom rule definitions."
  default     = {}
  type = map(object({
    description          = string
    direction            = string
    action               = string #(allow|deny)
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
}

variable "environment_prefix" {
  description = "The GCP envioment where the firewall rules will be created."
  type        = string
}

variable "network_name" {
  description = "The name of the vpc network."
  type        = string
}
