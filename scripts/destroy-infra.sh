#!/usr/bin/env bash
terraform init -reconfigure && terraform validate && terraform destroy -auto-approve && rm -rf .terraform