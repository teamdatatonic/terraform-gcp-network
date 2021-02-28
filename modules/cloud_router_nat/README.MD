## Resource Module for Cloud Nat & Router 

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
| asn | (Required) Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. | `number` | n/a | yes |
| environment\_prefix | The GCP envioment where the router nat will be created. | `string` | n/a | yes |
| nats | One or more NAT services created in a router. | `map(any)` | n/a | yes |
| network\_name | The name of the vpc network. | `string` | n/a | yes |
| project\_id | The ID of the project where this firewall rule will be created. | `any` | n/a | yes |
| region | Region where the router and NAT reside. | `string` | n/a | yes |
| router\_name | The name of the router. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_nat\_id | The Coud Nat ID's. |
| cloud\_nat\_name | The Coud Nat Names with format {{project}}/{{region}}/{{router}}/{{name}}. |
| cloud\_router\_id | The Coud Router ID. |
| router\_link | The URI of the Cloud Router. |
| router\_name | The Coud Router Name. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
