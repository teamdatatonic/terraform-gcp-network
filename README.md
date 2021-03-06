# Terraform Google Network Module

## Supported resources:
 - VPC
 - Subnets
 - Firwall rules
 - Cloud router nat 

## Prerequisites 
- Terraform 0.14+ ([tfswitch](https://warrensbox.github.io/terraform-switcher/) is the best way to install/manage)
- [Pre-commit](https://pre-commit.com/) 
- [commitizen](https://github.com/commitizen/cz-cli)

### Local Setup 
- install pre-commit: `brew install pre-commit`.
- install the git hook scripts: `pre-commit install`.


## Usage
You can go to the examples folder for each module usage, the usage of the resource modules could be like this in your own main.tf file:

```hcl
module "network_stack" {
    source  = "teamdatatonic/network/gcp//examples/simple_network"
    version = "1.0.0"

    project_id           = "<PROJECT ID>"
    region               = "europe-west2"
    environment_prefix   =  "dev"
    network_name         = "example-vpc"
    description          = "vpc-description"
    subnets = [
        {
            subnet_name                   = "subnet-01"
            subnet_ip                     = "10.10.10.0/24"
            subnet_region                 = "us-west1"
        },
        {
            subnet_name                   = "subnet-02"
            subnet_ip                     = "10.10.20.0/24"
            subnet_region                 = "us-west1"
            private_ip_google_access      = true
            description                   = "Subnet description"
        }
    ],
    cloud_router_nat_config = {
        test-router = {
            asn = 64514
            nats = {
                test-nat-1 = {
                    ip_allocation_option = "AUTO_ONLY"
                    source_subnetwork_ip_ranges_to_nat  = "LIST_OF_SUBNETWORKS"
                    subnetwork = {
                        name = management-subnet
                        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
                    }
                    log_config = null
                }
            }
        }
    }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.3 |
| google | ~> 3.31 |
| google-beta | ~> 3.31 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_router\_nat\_config | map of objects to config cloud nat & router. | `map(any)` | `{}` | no |
| delete\_default\_routes\_on\_create | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted, | `bool` | `false` | no |
| description | (Optional) An optional description of the VPC network. The resource must be recreated to modify this field. | `string` | `null` | no |
| environment\_prefix | The GCP envioment where the network will be created. | `string` | n/a | yes |
| firewall\_custom\_rules | map of custom rule definitions. | `map(any)` | `{}` | no |
| network\_name | The name of the network being created. | `string` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | `string` | n/a | yes |
| region | (Optional) Region where the router and NAT reside. | `string` | `null` | no |
| routing\_mode | The network routing mode (default 'GLOBAL'). | `string` | `"GLOBAL"` | no |
| subnets | The list of subnets to be created. | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
| subnet\_ids | List of subnet ids being created/ |
| subnet\_url | The self-links of subnets being created |
| subnets\_ips | The IPs and CIDRs of the subnets being created |
| subnets\_names | The names of the subnets being created |
| vpc\_network | The created network |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Contributing 
This repository enforces using [commitizen]((https://github.com/commitizen/cz-cli)) to structure the git commit messages  
- `git add`
- `git cz`
