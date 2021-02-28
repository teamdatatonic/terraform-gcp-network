output "vpc_network" {
  value       = module.vpc
  description = "The created network"
}

output "subnet_ids" {
  value       = module.subnets.subnet_id
  description = "List of subnet ids being created/"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "subnets_names" {
  value       = module.subnets.subnet_name
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = module.subnets.subnets_ips
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnet_url" {
  value       = module.subnets.subnet_url
  description = "The self-links of subnets being created"
}
