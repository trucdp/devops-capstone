#!/usr/bin/env bash
terraform init -reconfigure && terraform validate && terraform plan && terraform apply  -auto-approve

