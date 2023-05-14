#!/usr/bin/env bash
terraform init -backend-config=backend_configs/test.hcl -reconfigure && terraform validate && terraform plan && terraform apply -var-file=vars/test.tfvars -auto-approve

