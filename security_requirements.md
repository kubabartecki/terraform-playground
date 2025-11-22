# Security Requirements

## Requirements for 3:
| Requirement | Status |
| - | - |
| Create a dedicated Azure AD user with minimal permissions. Usage of the root account in the development environment  is prohibited | ? |
| Configure a security group or network security group for port filtering | ? |      
| README documentation with step-by-step description, configuration snapshots | ? |
## Requirements for 3.5:
| Requirement | Status |
| - | - |
| Place VM in a private subnetwork | ? |
| Internet access through  Load Balancer or Bastion/Jump Host in public subnetwork | ? |
| Turn on and configure monitor services (CPU, RAM, network traffic) | ? |
## Requirements for 4:
| Requirement | Status |
| - | - |
| Configure automatic and cycle backups | ? |
| Description of backup restore procedure | ? |
| Encrypt data in rest | ? |
| Detailed PDF documentation with:
| - Architecture diagrams | ? |
| - Step-by-step configuration description | ? |
| - Project decision justification | ? |
| - Deployment manual and verification | ? |
## Requirements for 4.5:
| Requirement | Status |
| - | - |
| Full process automation (Terraform) | ? |
| CI/CD pipeline with:
|  - Automatic change deployment in infrastructure | ? |
|  - OR  simple security scan | ? |
## Requirements for 5:
| Requirement | Status |
| - | - |
| Implement one of:
| - Deployment in an orchestration tool (AWS EKS, Azure AKS) | ? |
| - Threat recognition (Azure Sentinel), attack simulation | ? |
| - Identity management, SSO (Azure AD B2C) | ? |
| - Project presenation | ? |