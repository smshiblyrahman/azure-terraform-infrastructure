# Disaster Recovery

## RPO and RTO
- RPO: Dependent on workload backups.
- RTO: 2 hours to provision infra via Terraform.

## Recovery Steps
1. Recreate infra: `terraform apply`.
2. Restore App/DB data from backups.
3. Validate DNS and networking.
4. Verify health checks.
