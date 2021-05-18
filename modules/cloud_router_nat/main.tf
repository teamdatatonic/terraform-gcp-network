resource "google_compute_router" "cloud_router" {
  project = var.project_id
  region  = var.region
  name    = "${var.project_id}-${var.router_name}-${var.environment_prefix}"
  network = var.network_name

  bgp {
    asn = var.asn
  }
}

resource "google_compute_router_nat" "nat" {
  for_each                            = var.nats
  name                                = "${var.project_id}-${each.key}-${var.environment_prefix}"
  project                             = var.project_id
  router                              = google_compute_router.cloud_router.name
  region                              = google_compute_router.cloud_router.region
  nat_ip_allocate_option              = lookup(each.value, "ip_allocation_option")
  nat_ips                             = lookup(each.value, "nat_ips", null)
  source_subnetwork_ip_ranges_to_nat  = lookup(each.value, "source_subnetwork_ip_ranges_to_nat", null)
  min_ports_per_vm                    = lookup(each.value, "min_ports_per_vm", null)
  udp_idle_timeout_sec                = lookup(each.value, "udp_idle_timeout_sec", null)
  icmp_idle_timeout_sec               = lookup(each.value, "icmp_idle_timeout_sec", null)
  tcp_established_idle_timeout_sec    = lookup(each.value, "tcp_established_idle_timeout_sec", null)
  tcp_transitory_idle_timeout_sec     = lookup(each.value, "tcp_transitory_idle_timeout_sec", null)
  enable_endpoint_independent_mapping = lookup(each.value, "enable_endpoint_independent_mapping", null)

  dynamic "subnetwork" {
    for_each = each.value.subnetwork == null ? [] : [each.value.subnetwork]
    content {
      name                    = "${var.project_id}-${lookup(subnetwork.value, "name")}-${var.environment_prefix}"
      source_ip_ranges_to_nat = lookup(subnetwork.value, "source_ip_ranges_to_nat")

      secondary_ip_range_names = contains(subnetwork.value.source_ip_ranges_to_nat, "LIST_OF_SECONDARY_IP_RANGES") ? lookup(subnetwork.value, "secondary_ip_range_names") : []
    }

  }

  dynamic "log_config" {
    for_each = each.value.log_config == null ? [] : [each.value.log_config]

    content {
      enable = lookup(log_config.value, "enable")
      filter = lookup(log_config.value, "filter")
    }
  }
}
