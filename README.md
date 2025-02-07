# Terraform Infrastructure

This repository contains Terraform configurations for managing infrastructure in AWS, including EKS (Elastic Kubernetes Service) and VPC (Virtual Private Cloud). It is structured to support different environments and regions, with remote state management.

## Repository Structure

```
.
├── README.md                # Documentation for the repository
├── env                      # Environment-specific Terraform configurations
│   └── dev                  # Development environment
│       └── us-west-2        # AWS region: us-west-2
│           ├── eks          # EKS cluster configuration
│           │   ├── backend.tf          # Remote state backend configuration
│           │   ├── main.tf             # Main Terraform configuration
│           │   ├── outputs.tf          # Outputs definition
│           │   ├── terraform.tfvars    # Terraform variables
│           │   └── variables.tf        # Variable definitions
│           └── vpc          # VPC configuration
│               ├── backend.tf          # Remote state backend configuration
│               ├── main.tf             # Main Terraform configuration
│               ├── outputs.tf          # Outputs definition
│               ├── terraform.tfvars    # Terraform variables
│               └── variables.tf        # Variable definitions
└── remote-backend-resource   # Remote backend resources for state management
    ├── main.tf               # Backend resource configuration
    ├── terraform.tfvars       # Variables for backend setup
    └── variables.tf          # Variable definitions
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS credentials configured using `aws configure` or environment variables
- Proper IAM permissions for managing AWS resources

## Setup & Usage

## This repo uses workflows extensively...
- for initializing & creating the remote backend: use `Provision Remote Backend` 
- for initializing & creating the VPC           : use `validate VPC`, this is auto-initiate the VPC creation after successful completion.
- for initializing & creating the EKS           : use `validate EKS`, this is auto-initiate the EKS creation after successful completion.


## Remote State Management
The repository uses a remote backend for storing Terraform state. Ensure that the remote backend resources are created before running Terraform in individual environments.

## Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a pull request

## License
NA
