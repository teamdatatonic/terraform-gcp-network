output "subnet_name" {
  value       = [for u in google_compute_subnetwork.subnetwork : u.name]
  description = "The created firewall rule resources"
}

output "subnet_id" {
  value       = [for u in google_compute_subnetwork.subnetwork : u.id]
  description = "The created firewall rule resources"
}

output "subnet_url" {
  value       = [for u in google_compute_subnetwork.subnetwork : u.self_link]
  description = "The URI of the created resource."
}

output "subnets_ips" {
  value       = [for u in google_compute_subnetwork.subnetwork : u.ip_cidr_range]
  description = "List of subnet ups"
}
