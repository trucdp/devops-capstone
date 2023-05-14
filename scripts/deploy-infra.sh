#!/usr/bin/env bash

cd infrastructure
terraform init
terraform plan
terraform apply -auto-approve
cd ../lbc
terraform init
terraform plan
terraform apply -auto-approve