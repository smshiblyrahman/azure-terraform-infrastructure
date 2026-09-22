# Troubleshooting

## Network Issues
- Check NSG rules on Source/Destination.
- Verify Route Tables.
- Check if App is listening on port.

## Terraform State Issues
- Remote state locked? Force unlock via `terraform force-unlock <lock-id>`.
- State access denied? Check RBAC on `selisedemotfstate` storage account.
