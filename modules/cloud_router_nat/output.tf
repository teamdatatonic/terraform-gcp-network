output "cloud_nat_name" {
  value       = [for u in google_compute_router_nat.nat : u.name]
  description = "The Coud Nat Names with format {{project}}/{{region}}/{{router}}/{{name}}."
}

output "cloud_nat_id" {
  value       = [for u in google_compute_router_nat.nat : u.id]
  description = "The Coud Nat ID's."
}

output "router_name" {
  value       = google_compute_router.cloud_router.name
  description = "The Coud Router Name."
}

output "cloud_router_id" {
  value       = google_compute_router.cloud_router.id
  description = "The Coud Router ID."
}

output "router_link" {
  value       = google_compute_router.cloud_router.self_link
  description = "The URI of the Cloud Router."
}
