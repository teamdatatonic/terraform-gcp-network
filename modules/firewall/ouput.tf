output "firewall_rule_id" {
  value       = [for u in google_compute_firewall.dynamic_firewall_rules : u.id]
  description = "The created firewall rule resources"
}

output "rule_url" {
  value       = [for u in google_compute_firewall.dynamic_firewall_rules : u.self_link]
  description = " The URI of the created resource."
}
