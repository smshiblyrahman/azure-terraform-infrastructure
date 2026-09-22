#!/bin/bash
set -e

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

cd "../environments/$ENV"

echo "Deploying to $ENV environment..."
terraform init
terraform plan -out=tfplan
terraform apply -auto-approve tfplan

echo "Deployment complete."
