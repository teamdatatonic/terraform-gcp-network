resource "google_compute_firewall" "dynamic_firewall_rules" {
  for_each = var.firewall_custom_rules

  project                 = var.project_id
  name                    = "${var.project_id}-${each.key}-${var.environment_prefix}"
  description             = each.value.description
  direction               = each.value.direction
  network                 = var.network_name
  source_ranges           = each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges      = each.value.direction == "EGRESS" ? each.value.ranges : null
  source_tags             = each.value.use_service_accounts || each.value.direction == "EGRESS" ? null : each.value.sources
  source_service_accounts = each.value.use_service_accounts && each.value.direction == "INGRESS" ? each.value.sources : null
  target_tags             = each.value.use_service_accounts ? null : each.value.targets
  target_service_accounts = each.value.use_service_accounts ? each.value.targets : null
  disabled                = lookup(each.value.extra_attributes, "disabled", false)
  priority                = lookup(each.value.extra_attributes, "priority", 1000)


  dynamic "log_config" {
    for_each = contains(keys(each.value.extra_attributes), "metadata") ? map("temp", each.value.extra_attributes) : {}
    content {
      metadata = lookup(log_config.value, "metadata")
    }
  }

  dynamic "allow" {
    for_each = [for rule in each.value.rules : rule if each.value.action == "allow"]
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }

  dynamic "deny" {
    for_each = [for rule in each.value.rules : rule if each.value.action == "deny"]
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }

}
