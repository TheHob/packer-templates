## Environment variables required to run this packer build

## Azure credentials if necessary
#
#export ARM_SUBSCRIPTION_ID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
#export ARM_CLIENT_ID="bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
#export ARM_CLIENT_SECRET="cccccccc-cccc-cccc-cccc-cccccccccccc"
#export ARM_TENANT_ID="dddddddd-dddd-dddd-dddd-dddddddddddd"
#export subscription_id="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
#export client_id="bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
#export client_secret="cccccccc-cccc-cccc-cccc-cccccccccccc"

## Packer build variables
#
export CONSUL_VERSION="0.9.3"
export NOMAD_VERSION="0.6.3"
export VAULT_VERSION="0.8.3"
export PACKER_VERSION="0.12.3"
export TERRAFORM_VERSION="0.10.0"
export UBUNTU_VERSION="16.04"
export S3BUCKET="${S3BUCKET}"
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
export CONSUL_RELEASE="${CONSUL_VERSION}"
export VAULT_RELEASE="${VAULT_VERSION}"
export DISTRIBUTION="ent"
export CONSUL_ENT_URL=$(AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" aws s3 presign --region="us-east-1" s3://${S3BUCKET}/consul-enterprise/${CONSUL_VERSION}/consul-enterprise_${CONSUL_VERSION}+ent_linux_amd64.zip --expires-in 600)
export VAULT_ENT_URL=$(AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" aws s3 presign --region="us-east-1" s3://${S3BUCKET}/vault-enterprise/${VAULT_VERSION}/vault-enterprise_${VAULT_VERSION}_linux_amd64.zip --expires-in 600)

echo 'Example command:
  AZURE_RESOURCE_GROUP="PackerImages" AZURE_LOCATION="West US" PACKER_ENVIRONMENT="dev" packer build hashistack-azure.json'
