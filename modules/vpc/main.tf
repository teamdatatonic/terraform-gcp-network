resource "google_compute_network" "core_vpc_network" {
  project                         = var.project_id
  name                            = "${var.project_id}-${var.network_name}-${var.environment_prefix}"
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
  description                     = var.description
  mtu                             = var.mtu
}

resource "google_compute_route" "default-internet-gateway" {
  count = var.default_internet_gateway ? 1 : 0

  name             = "default-internet-gateway"
  project          = var.project_id
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.core_vpc_network.name
  next_hop_gateway = "default-internet-gateway"
  priority         = 100
}
