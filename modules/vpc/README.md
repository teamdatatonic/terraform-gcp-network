
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.3 |
| google | ~> 3.31 |
| google-beta | ~> 3.31 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.31 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_create\_subnetworks | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| delete\_default\_routes\_on\_create | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted, | `bool` | `false` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| environment\_prefix | The GCP envioment where the vpc will be created. | `string` | n/a | yes |
| mtu | The network MTU (default '1460'). Must be a value between 1460 and 1500 inclusive. | `number` | `1460` | no |
| network\_name | The name of the network being created. | `any` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created. | `any` | n/a | yes |
| routing\_mode | The network routing mode (default 'GLOBAL'). | `string` | `"GLOBAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| network | The VPC resource being created. |
| network\_name | The name of the VPC being created. |
| network\_self\_link | The URI of the VPC being created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
