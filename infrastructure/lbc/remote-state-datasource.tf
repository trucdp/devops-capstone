# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "central-mcloud-terraform-state"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}