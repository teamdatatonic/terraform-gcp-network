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
| environment\_prefix | The GCP envioment where the vpc will be created. | `any` | n/a | yes |
| network\_name | The name of the network being created | `any` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
