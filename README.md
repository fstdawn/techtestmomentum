Pre-requisites
==============

-   Install(https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) and configure AWS CLI(https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

-   Install Terraform: https://learn.hashicorp.com/tutorials/terraform/install-cli

-   Install opa: https://learn.hashicorp.com/tutorials/terraform/install-cli

```
	On macOS (64-bit):
    curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_darwin_amd64

    On Linux (64-bit):
    curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64

	chmod 755 ./opa

    sudo mv ./opa /usr/local/bin/opa
```

- Clone or Download the repo: https://github.com/fstdawn/techtestmomentum
	git clone: https://github.com/fstdawn/techtestmomentum.git


To create an AWS environment with a VPC & two subnets
=====================================================

Without using aws vpc terraform module
--------------------------------------

- Move to vpc directory of the cloned github repo
- Update the variables like vpc cidr, subnet cidr, etc, inside variables.tf file
- Run the terraform commands in the following order:
```
    $ terraform init
    $ terraform plan
    $ terraform apply
```

With aws vpc terraform module(https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
--------------------------------------

- Move to vpcmodules directory of the cloned github repo
- Update the variables like vpc cidr, subnet cidr, etc, inside variables.tf file
- Run the terraform commands in the following order:
```
    $ terraform init
    $ terraform plan
    $ terraform apply
```
Note: VPC module is more dynamic and we can utilize a prebuilt package to create dyanamic VPC resources in aws

To test OPA which will check for creation of new subnets and will deny the change.
==================================================================================
- Move to vpc directory of the cloned github repo
- Update the variables like vpc cidr, subnet cidr, etc, inside variables.tf file
- Run the commands in the following order
```
    $ terraform init
    $ terraform plan --out tfplan.binary
    $ terraform show -json tfplan.binary > tfplan.json
    Run Opa evaluation
    $ opa eval --format pretty --data my_policy.rego --input tfplan.json "data.terraform"
```
Note: The policy will deny the creation of new subnets.


To Deploy RDS DB instance
=========================
- Move to rds-instance directory of the cloned github repo
- Update the variables inside variables.tf file
- Run the terraform commands in the following order:
```
    $ terraform init
    $ terraform plan
    $ terraform apply
```
Note: This deploys mysql 5.7.19.

To Deploy RDS DB Cluster
=========================

- Move to rds-cluster directory of the cloned github repo
- Update the variables inside variables.tf file
- Run the terraform commands in the following order:
```
    $ terraform init
    $ terraform plan
    $ terraform apply
```
Note: This deploys aurora-postgresql 9.6.9.

Deploy AWS Config Rule and Remediation using Cloudformation:
===========================================================

To deploy "rds-instance-deletion-protection-enabled", which has default SSM document available for remediation from Amazon.
---------------------------------------------------------------------------------------------------------------------------

Deploy cfn/testtemplate1.json. Update the parameter CreateRecorderForRDS as 'true' if the config recorder is not enabled.
Details on how to deploy Cloudformation in the below link
CLI - aws cloudformation deploy --template-file ./cfn/testtemplate1.json --stack-name my-new-stack
- https://docs.aws.amazon.com/cli/latest/reference/cloudformation/deploy/index.html

- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-stack.html

Note: cfn/testtemplate.json deploys config rule evaluation for rds-cluster-deletion-protection-enabled. However, there is no default remediation document available. An SSM document needs to be created for remediation action and is in TODO...

ADDITIONAL NOTES
++++++++++++++++
Sensitive Data in Terraform State:
-----------------------------------

Terraform state can contain sensitive data, depending on the resources in use. The state contains resource IDs and all resource attributes. For resources such as databases, this may contain initial passwords. When using local state, state is stored in plain-text JSON files.

When using remote state, state is only ever held in memory when used by Terraform. If we manage any sensitive data with Terraform (like database passwords, user passwords, or private keys), treat the state itself as sensitive data. Storing state remotely can provide better security. Terraform does not persist state to the local disk when remote state is in use, and some backends can be configured to encrypt the state data at rest.