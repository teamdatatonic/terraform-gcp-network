output "cloud_nat_name" {
  value       = [for u in google_compute_router_nat.nat : u.name]
  description = "An identifier for the resource with format {{project}}/{{region}}/{{router}}/{{name}}"
}


output "cloud_nat_id" {
  value       = [for u in google_compute_router_nat.nat : u.id]
  description = "An identifier for the resource with format {{project}}/{{region}}/{{router}}/{{name}}"
}

output "router_name" {
  value = google_compute_router.cloud_router.name
}

output "cloud_router_id" {
  value       = google_compute_router.cloud_router.id
  description = "an identifier for the resource with format projects/{{project}}/regions/{{region}}/routers/{{name}}"
}


output "router_link" {
  value = google_compute_router.cloud_router.self_link
}
