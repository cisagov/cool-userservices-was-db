# cool-userservices-was-db #

[![GitHub Build Status](https://github.com/cisagov/cool-userservices-was-db/workflows/build/badge.svg)](https://github.com/cisagov/cool-userservices-was-db/actions)

This is a Terraform deployment for creating the Web Application Scanning (WAS)
database table in the COOL User Services account.

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [backend.tf](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [backend.tf](backend.tf)).
- Access to all of the Terraform remote states specified in
  [remote_states.tf](remote_states.tf).

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 4.9 |
| aws.organizationsreadonly | ~> 4.9 |
| aws.userservicesprovisionaccount | ~> 4.9 |
| terraform | n/a |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_dynamodb_table.stakeholders_with_sort_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.stakeholders_without_sort_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.provisionwasdb_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.read_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.provisionwasdb_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.userservices](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.provisionwasdb_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_only_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_write_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.users_account_assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.cool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [terraform_remote_state.master](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.userservices](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| provisionwasdb\_policy\_description | The description to associate with the IAM policy that allows provisioning of the WAS DynamoDB tables in the User Services account. | `string` | `"Allows provisioning of the WAS DB in the User Services account."` | no |
| provisionwasdb\_policy\_name | The name to assign the IAM policy that allows provisioning of the WAS DynamoDB tables in the User Services account. | `string` | `"ProvisionWASDB"` | no |
| read\_only\_policy\_role\_description | The description to associate with the IAM policy and role that allows read-only access to the WAS DynamoDB tables in the User Services account. | `string` | `"Allows read-only access to the WAS DB in the User Services account."` | no |
| read\_only\_policy\_role\_name | The name to assign the IAM policy and role that allows read-only access to the WAS DynamoDB tables in the User Services account. | `string` | `"WAS-DB-ReadOnly"` | no |
| read\_write\_policy\_role\_description | The description to associate with the IAM policy and role that allows read-write access to the WAS DynamoDB tables in the User Services account. | `string` | `"Allows read-write access to the WAS DB in the User Services account."` | no |
| read\_write\_policy\_role\_name | The name to assign the IAM policy and role that allows read-write access to the WAS DynamoDB tables in the User Services account. | `string` | `"WAS-DB-ReadWrite"` | no |
| stakeholders\_table\_name | The name of the stakeholders DynamoDB table. | `string` | `"stakeholders"` | no |
| stakeholders\_table\_partition\_key | The name of the stakeholders DynamoDB table partition (hash) key.  It's best to choose an attribute with a wide range of values that is likely to have evenly distributed access patterns. | `string` | `"id"` | no |
| stakeholders\_table\_partition\_key\_type | The data type of the stakeholders DynamoDB table partition (hash) key.  See `https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypeDescriptors` for a list of valid values. | `string` | `"S"` | no |
| stakeholders\_table\_point\_in\_time\_recovery | Whether to enable point-in-time recovery for the stakeholders DynamoDB table. | `bool` | `false` | no |
| stakeholders\_table\_read\_capacity | The number of read units for the stakeholders DynamoDB table. | `number` | `5` | no |
| stakeholders\_table\_sort\_key | The name of the stakeholders DynamoDB table sort (range) key. | `string` | `""` | no |
| stakeholders\_table\_sort\_key\_type | The data type of the stakeholders DynamoDB table sort (range) key.  See `https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypeDescriptors` for a list of valid values. | `string` | `"S"` | no |
| stakeholders\_table\_write\_capacity | The number of write units for the stakeholders DynamoDB table. | `number` | `5` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| read\_only\_role | The WAS database read-only role. |
| read\_write\_role | The WAS database read-write role. |
| stakeholders\_table | The WAS stakeholders DynamoDB table. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is just the main directory.

Your first `terraform apply` will fail with an `AccessDeniedException`.  This is
expected since the required policy is not attached to the account provisioning
role until after the first `terraform apply`.  Simply run `terraform apply`
again and it should succeed.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
