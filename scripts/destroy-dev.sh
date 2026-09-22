#!/bin/bash
set -e

echo "Destroying dev environment..."
cd ../environments/dev

terraform destroy -auto-approve

echo "Destroy complete."
