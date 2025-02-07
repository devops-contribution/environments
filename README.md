# Terraform Infrastructure

This repository contains Terraform configurations for managing infrastructure in AWS, including EKS (Elastic Kubernetes Service) and VPC (Virtual Private Cloud). It is structured to support different environments and regions, with remote state management.

## Repository Structure

```
.
├── README.md
├── env
│   └── dev
│       └── us-west-2
│           ├── eks
│           │   ├── backend.tf
│           │   ├── main.tf
│           │   ├── outputs.tf
│           │   ├── terraform.tfvars
│           │   └── variables.tf
│           ├── node-group
│           │   ├── backend.tf
│           │   ├── main.tf
│           │   ├── terraform.tfvars
│           │   └── variables.tf
│           └── vpc
│               ├── backend.tf
│               ├── main.tf
│               ├── outputs.tf
│               ├── terraform.tfvars
│               └── variables.tf
└── remote-backend-resource
    ├── main.tf
    ├── terraform.tfvars
    └── variables.tf

```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS credentials configured using `aws configure` or environment variables
- Proper IAM permissions for managing AWS resources

## Setup & Usage

## This repo uses workflows extensively, and there is specific order of workflow execution. See below,
- for initializing & creating the remote backend: use `Provision Remote Backend` 
- for initializing & creating the VPC           : use `validate VPC`, this is auto-initiate the VPC creation after successful completion.
- for initializing & creating the EKS           : use `validate EKS`, this is auto-initiate the EKS creation after successful completion.
- for initializing & creating the Node Group           : use `validate Node Group`, this is auto-initiate the Node Group creation after successful completion.


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
