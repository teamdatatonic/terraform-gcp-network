module "vpc" {
  source             = "./modules/vpc"
  project_id         = var.project_id
  environment_prefix = var.environment_prefix
  network_name       = var.network_name
  description        = var.description
}

module "subnets" {
  source                          = "./modules/subnets"
  project_id                      = var.project_id
  environment_prefix              = var.environment_prefix
  network_name                    = module.vpc.network_name
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
  subnets                         = var.subnets

}

module "cloud_nat_router" {
  for_each           = var.cloud_router_nat_config
  source             = "./modules/cloud_router_nat"
  project_id         = var.project_id
  region             = var.region
  environment_prefix = var.environment_prefix
  network_name       = module.vpc.network_name
  router_name        = each.key
  asn                = lookup(each.value, "asn", null)
  nats               = each.value.nats
  depends_on         = [module.subnets]

}

module "firewall_network" {
  source                = "./modules/firewall"
  project_id            = var.project_id
  network_name          = module.vpc.network_name
  environment_prefix    = var.environment_prefix
  firewall_custom_rules = var.firewall_custom_rules
}
