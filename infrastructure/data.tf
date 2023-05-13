data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_ebs_default_kms_key" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}
