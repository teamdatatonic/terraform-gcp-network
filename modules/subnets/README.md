
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_region | Allows a default region to be passed in | `string` | `""` | no |
| environment\_prefix | The GCP envioment where the subnets will be created. | `string` | n/a | yes |
| network\_name | The name of the vpc network. | `string` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created. | `string` | n/a | yes |
| subnets | The list of subnets to be created. | `list(map(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subnet\_id | The created Subnet IDs. |
| subnet\_name | The created Subnet Resource Names. |
| subnet\_url | The URI of the created resource. |
| subnets\_ips | List of Subnet IPs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
