resource "google_compute_network" "core_vpc_network" {
  project                         = var.project_id
  name                            = "${var.project_id}-${var.network_name}-${var.environment_prefix}"
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
  description                     = var.description
  mtu                             = var.mtu

}