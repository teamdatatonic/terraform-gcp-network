
locals {
  network_subnets = flatten([
    for subnet in var.subnets : {
      subnet_name              = subnet.subnet_name
      ip_cidr_range            = subnet.subnet_ip
      region                   = subnet.subnet_region
      private_ip_google_access = lookup(subnet, "private_ip_google_access", false)
      description              = lookup(subnet, "description", null)

      enable_logs = [{
        aggregation_interval = lookup(subnet, "logs_interval", "INTERVAL_5_SEC")
        flow_sampling        = lookup(subnet, "logs_sampling", "0.5")
        metadata             = lookup(subnet, "logs_metadata", "INCLUDE_ALL_METADATA")
        filter_expr          = lookup(subnet, "logs_filter_expr", true)
      }]
    }
  ])
  iterator = { for subnet in local.network_subnets : subnet.subnet_name => subnet }
}

resource "google_compute_subnetwork" "subnetwork" {
  for_each = local.iterator

  project                  = var.project_id
  network                  = var.network_name
  name                     = "${var.project_id}-${each.value.subnet_name}-${var.environment_prefix}"
  ip_cidr_range            = each.value.ip_cidr_range
  region                   = lookup(each.value, "region", var.default_region)
  description              = each.value.description
  private_ip_google_access = each.value.private_ip_google_access

  #checkov:skip=CKV_GCP_26: configurable
  dynamic "log_config" {
    for_each = each.value.enable_logs
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
      filter_expr          = log_config.value.filter_expr
    }
  }

}
