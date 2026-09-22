# Project 1 — Multi-Environment Azure Cloud Infrastructure with Terraform

## SELISE-Oriented Technical Implementation Plan

> **Purpose:** Build a production-style Azure infrastructure project that demonstrates the infrastructure operations, automation, governance, security, cost-awareness, troubleshooting, and documentation capabilities expected from a SELISE infrastructure/DevOps engineer.

## 1. Project Positioning

This project is the **infrastructure foundation** for the complete six-project portfolio.

The supplied project specification defines Dev/Staging/Production Azure environments, segmented networking, Azure VMs, Storage Accounts, Key Vault, Load Balancer, reusable Terraform modules, Azure remote state, `.tfvars`, workspaces, tagging, RBAC, managed identities, encryption, and Azure Firewall/NSGs. fileciteturn0file0L9-L32

For SELISE alignment, the project should additionally demonstrate the operational mindset visible in SELISE's current SysOps role: infrastructure administration, Azure IaaS/PaaS/SaaS operations, connectivity/routing/DNS/firewalls, VMs, storage, backups/disaster recovery, availability, troubleshooting, cost governance, CI/CD automation, security hardening, IAM/RBAC, and scripting with Bash/Python/PowerShell. citeturn0search0

## 2. Business/Operational Scenario

Assume SELISE is operating a customer-facing digital platform with:

- Web/API workloads.
- Multiple environments.
- Private application services.
- Persistent data.
- Centralized secrets.
- Controlled administrative access.
- Monitoring and alerting.
- Automated infrastructure delivery.

The infrastructure must be:

- Reproducible.
- Auditable.
- Secure.
- Cost-conscious.
- Recoverable.
- Observable.
- Easy for another engineer to operate.

## 3. Target Architecture

```text
                           Internet
                              |
                       Azure Load Balancer
                              |
                    +---------+---------+
                    |   Public Subnet   |
                    | Edge / Ingress    |
                    +---------+---------+
                              |
                    +---------v---------+
                    | Private App Tier  |
                    | VM / App Workload |
                    +---------+---------+
                              |
                    +---------v---------+
                    | Database Subnet   |
                    | Private Data      |
                    +-------------------+

     +------------------------------------------------+
     |                  Azure VNet                    |
     |                                                |
     | Public | Private App | Private Data            |
     |                                                |
     | NSG + Routes + Firewall + Private Endpoints    |
     +------------------------------------------------+
              |                 |
          Key Vault         Storage/Backups
              |
        Managed Identity

                 Terraform
                     |
              Remote State
                     |
          Dev / Staging / Prod
```

## 4. SELISE Capability Mapping

| SELISE-oriented need | Demonstrated here |
|---|---|
| Azure infrastructure operations | VNet, VM, storage, load balancing |
| Connectivity/routing | Subnets, routes, NSGs, firewall |
| Infrastructure automation | Terraform modules |
| Environment management | Dev/Staging/Production |
| Security | RBAC, managed identity, Key Vault |
| Cost governance | Tags, sizing, lifecycle policies |
| Availability | Load balancing, health checks |
| Backup/DR foundation | Storage and recovery design |
| Troubleshooting | Validation/runbooks |
| Automation scripting | Bash/Python/PowerShell |
| Governance | Policy, naming, tagging |
| Documentation | Architecture/runbooks |

## 5. Repository Structure

```text
azure-terraform-infrastructure/
├── modules/
│   ├── networking/
│   ├── compute/
│   ├── security/
│   ├── storage/
│   └── monitoring/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── production/
├── bootstrap/
│   └── remote-state/
├── policies/
├── scripts/
│   ├── validate.sh
│   ├── deploy.sh
│   ├── destroy-dev.sh
│   └── cost-report.py
├── docs/
│   ├── architecture.md
│   ├── operations.md
│   ├── disaster-recovery.md
│   └── troubleshooting.md
├── versions.tf
├── providers.tf
└── README.md
```

## 6. Naming Convention

Use predictable names:

```text
<company>-<project>-<environment>-<resource>

selise-demo-dev-vnet
selise-demo-staging-vnet
selise-demo-prod-vnet
```

The exact naming standard should be documented once and reused through Terraform locals.

## 7. Terraform Module Strategy

Modules should have a small, stable public interface.

Example:

```hcl
module "networking" {
  source = "../../modules/networking"

  name                = var.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  vnet_cidr               = var.vnet_cidr
  public_subnet_cidr      = var.public_subnet_cidr
  application_subnet_cidr = var.application_subnet_cidr
  database_subnet_cidr    = var.database_subnet_cidr

  tags = local.common_tags
}
```

Do not copy/paste complete infrastructure definitions between environments.

## 8. Remote State

The supplied project uses Azure Storage for remote Terraform state and state locking. fileciteturn0file0L21-L25

Implementation:

1. Bootstrap a dedicated state resource group.
2. Create Storage Account.
3. Create a private/restricted state container.
4. Configure the AzureRM backend.
5. Restrict state access to deployment identities.
6. Enable appropriate storage protection.
7. Never commit state files to Git.
8. Document state recovery.

## 9. Environment Isolation

Use:

```text
dev
  low-cost resources
  rapid experimentation

staging
  production-like topology
  release validation

production
  strongest access controls
  restricted changes
  higher availability
```

The original specification proposes both `.tfvars` and Terraform workspaces. fileciteturn0file0L23-L25

For a portfolio implementation, document the trade-off explicitly:

- Separate state/configuration boundaries are generally easier to reason about for critical production infrastructure.
- Workspaces can still be demonstrated where appropriate.
- The important capability is predictable environment isolation, not the workspace feature itself.

## 10. Network Architecture

Create:

```text
VNet
├── public-subnet
├── application-subnet
├── database-subnet
└── management/private-endpoint subnets as required
```

Rules:

- Database subnet has no public ingress.
- Application tier receives only required traffic.
- Management access is restricted.
- Outbound traffic is controlled where required.
- Private services use private connectivity.

## 11. DNS and Routing

Because infrastructure operations often include DNS and connectivity troubleshooting, explicitly document:

- Private DNS zones.
- Application DNS.
- Internal service resolution.
- Route tables.
- Default routes.
- Firewall routing.
- Name-resolution troubleshooting.

Example troubleshooting flow:

```text
Application cannot reach database
        |
DNS resolution?
        |
Route exists?
        |
NSG allows traffic?
        |
Firewall allows traffic?
        |
Database listening?
        |
Authentication valid?
```

## 12. VM Operations

For Azure VMs:

- Use managed identities.
- Define OS/image versions.
- Configure disks.
- Configure availability.
- Restrict administrative access.
- Enable monitoring.
- Apply patching strategy.
- Document restart/recovery procedures.

Do not place administrator passwords in Terraform variables committed to Git.

## 13. Storage

Demonstrate:

- Storage Account provisioning.
- Lifecycle policies.
- Secure access.
- Backup/archive strategy.
- Retention considerations.
- Access logging where applicable.

The supplied project explicitly includes Storage Accounts with lifecycle management. fileciteturn0file0L13-L18

## 14. Identity and Access

Implement:

```text
Human engineer
    |
Azure identity
    |
RBAC
    |
Minimum required permissions
```

Workloads:

```text
Application
    |
Managed Identity
    |
Azure Resource
```

Avoid long-lived service credentials whenever a managed identity is practical.

## 15. Security Controls

Implement:

- NSGs.
- Azure Firewall where justified.
- RBAC.
- Managed identities.
- Encryption at rest.
- TLS.
- Private endpoints.
- Restricted administrative access.
- Audit logging.

These directly extend the supplied security implementation. fileciteturn0file0L28-L32

## 16. Cost Governance

SELISE's current SysOps role explicitly mentions infrastructure cost and budget tracking and optimization/governance initiatives. citeturn0search0

Demonstrate:

- Resource tagging.
- Environment-specific sizing.
- Dev auto-shutdown where appropriate.
- Storage lifecycle rules.
- Unused-resource detection.
- Monthly cost review.
- Cost ownership tags.

Example tags:

```text
environment
project
owner
cost-center
managed-by
criticality
```

## 17. Backup and Disaster Recovery

Create a documented recovery model:

```text
Resource failure
    |
Restore latest valid backup
    |
Recreate infrastructure from Terraform
    |
Restore application/data
    |
Validate DNS/networking
    |
Health checks
    |
Service restored
```

Document:

- RPO.
- RTO.
- Backup frequency.
- Retention.
- Restore procedure.
- Recovery ownership.

Do not claim a tested RPO/RTO unless you actually test it.

## 18. Validation Pipeline

Run:

```bash
terraform fmt -check
terraform validate
terraform plan
```

Add infrastructure security scanning.

Then:

```text
Plan
 ↓
Review
 ↓
Apply
 ↓
Azure validation
 ↓
Smoke tests
```

## 19. CI/CD for Infrastructure

A SELISE-oriented repository should make infrastructure changes reviewable:

```text
Pull Request
    |
Terraform fmt
    |
Terraform validate
    |
Security scan
    |
Terraform plan
    |
Code review
    |
Merge
    |
Controlled deployment
```

Production applies should have stronger approval controls than Dev.

## 20. Scripting

Include operational scripts using:

- Bash.
- Python.
- PowerShell.

Examples:

```text
check-resource-health.py
find-unused-resources.py
validate-network.sh
rotate-test-secret.sh
```

The current SELISE SysOps posting explicitly calls out Bash, Python, or PowerShell for operational automation. citeturn0search0

## 21. Implementation Phases

### Phase 1 — Foundation

- Repository.
- Terraform versions.
- Azure authentication.
- Naming/tagging.
- Remote state.

### Phase 2 — Networking

- VNet.
- Subnets.
- NSGs.
- Routes.
- DNS.
- Firewall.

### Phase 3 — Compute/Storage

- VMs.
- Load balancer.
- Storage.
- Health checks.

### Phase 4 — Security

- Key Vault.
- RBAC.
- Managed identities.
- Private endpoints.

### Phase 5 — Operations

- Monitoring.
- Backup.
- DR documentation.
- Cost controls.

### Phase 6 — Automation

- CI validation.
- Terraform plans.
- Deployment scripts.
- Operational scripts.

## 22. Acceptance Criteria

```text
[ ] Dev environment deploys reproducibly
[ ] Staging matches intended topology
[ ] Production configuration is isolated
[ ] Terraform state is remote
[ ] No secrets are committed
[ ] Network tiers are isolated
[ ] Database is not publicly exposed
[ ] RBAC is least privilege
[ ] Managed identities work
[ ] Resource tags are present
[ ] Backup/restore procedure is documented
[ ] Cost-control strategy is documented
[ ] Troubleshooting runbook exists
```

## 23. Interview Questions This Project Should Prepare You For

1. Why Terraform?
2. How do you prevent configuration drift?
3. How do you protect Terraform state?
4. How would you troubleshoot a VM that cannot reach another subnet?
5. How would you troubleshoot DNS?
6. How do you control Azure costs?
7. How do you implement least privilege?
8. How would you recover production infrastructure?
9. How do you safely change production networking?
10. What should be automated and what should require human approval?

## 24. Evidence to Put in GitHub

```text
README.md
architecture.png
terraform plan examples
network diagram
security checklist
cost-governance.md
backup-dr.md
troubleshooting.md
CI workflow
sample Terraform modules
```

This makes the project demonstrable rather than simply a list of technologies.
