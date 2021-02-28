
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
| environment\_prefix | The GCP envioment where the firewall rules will be created. | `string` | n/a | yes |
| firewall\_custom\_rules | List of custom rule definitions. | <pre>map(object({<br>    description          = string<br>    direction            = string<br>    action               = string #(allow|deny)<br>    ranges               = list(string)<br>    sources              = list(string)<br>    targets              = list(string)<br>    use_service_accounts = bool<br>    rules = list(object({<br>      protocol = string<br>      ports    = list(string)<br>    }))<br>    extra_attributes = map(string)<br>  }))</pre> | `{}` | no |
| network\_name | The name of the vpc network. | `string` | n/a | yes |
| project\_id | The ID of the project where this firewall rule will be created. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| firewall\_rule\_id | The created firewall rule resources. |
| rule\_url | The URI of the created resource. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
