module "simple_vpc" {
  source             = "../../modules/vpc"
  project_id         = var.project_id
  network_name       = var.network_name
  environment_prefix = var.environment_prefix

}
