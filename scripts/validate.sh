#!/bin/bash
set -e

echo "Validating Terraform code..."
terraform fmt -check -recursive
terraform validate

echo "Validation complete."
