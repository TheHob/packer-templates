# Intro
This repo contains Packer templates used for modules in hashicorp-modules

---

## HashiStack  
Contains provider specific templates that installs HashiCorp software on a single node (Consul, Nomad, Vault, consul-template and envconsul).

### Building HashiStack images locally (outside of the CI pipeline)
This is a workflow that's designed to allow you to trigger local builds of enterprise Packer images. This functionality is currently under development. The example below is all that's been tested.

This is particularly useful for customers on Azure, as it's difficult to share machine images with them.

#### Prerequisites
- Credentials to access HashiCorp enterprise binaries.
- If you are building Azure images, you'll need to follow the steps at the below links to set up and authenticate with an Azure account.
  - [Azure setup instructions](https://github.com/tdsacilowski/azure-consul/blob/master/README.md#deployment-prerequisites)
  - This [Azure RM setup guide](https://www.terraform.io/docs/providers/azurerm/index.html) is linked in the above documentation.

#### An example using Packer to build images on Azure
After authenticating (see above) with Azure, perform the following steps.

- Authenticate with Azure using the [Azure setup instructions](https://github.com/tdsacilowski/azure-consul/blob/master/README.md#deployment-prerequisites).
- Create a file like the below with your credentials and source it. (`vi env.sh`, then `source env.sh`)
  ```
  # Exporting variables in both cases just in case, no pun intended
  export ARM_SUBSCRIPTION_ID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  export ARM_CLIENT_ID="bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
  export ARM_CLIENT_SECRET="cccccccc-cccc-cccc-cccc-cccccccccccc"
  export ARM_TENANT_ID="dddddddd-dddd-dddd-dddd-dddddddddddd"
  export subscription_id="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  export client_id="bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
  export client_secret="cccccccc-cccc-cccc-cccc-cccccccccccc"
  ```
- With the root of this repo as your working directory, run the following:
  ```
  # Export prerequisite variables
  #
  $ export S3BUCKET="${ENTERPRISE_BINARY_S3BUCKET}"
  $ export AWS_ACCESS_KEY_ID="${YOUR_AWS_BINARY_ACCESS_KEY_ID}"
  $ export AWS_SECRET_ACCESS_KEY="${YOUR_AWS_BINARY_SECRET_ACCESS_KEY}"
  $ cd hashistack
  #
  # Run the next two steps before each packer build to regenerate URLs,
  # as the enterprise download URLs expire after 10 minutes#
  $ source ../versions.sh
  $ source ../local-variables.sh
  $ AZURE_RESOURCE_GROUP="PackerImages" AZURE_LOCATION="West US" PACKER_ENVIRONMENT="dev" packer build hashistack-azure.json
  ```

***Notes:***
- Right now using the [hashistack-azure](https://github.com/TheHob/hashistack-poc/tree/master/terraform-azure) and an image resulting from the above, it's possible to deploy a HashiStack cluster (some functional tests pending) on Ubuntu and RHEL. You may need to start Vault on RHEL.
- Make sure to source `versions.sh` and `local-variables.sh` before each packer build as the AWS enterprise download URLs expire after 10 minutes.
