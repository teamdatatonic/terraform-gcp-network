output "network" {
  value       = google_compute_network.core_vpc_network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.core_vpc_network.name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.core_vpc_network.self_link
  description = "The URI of the VPC being created"
}
