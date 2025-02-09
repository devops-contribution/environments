# Terraform Infrastructure

This repository contains Terraform configurations for managing infrastructure in AWS, including EKS (Elastic Kubernetes Service) and VPC (Virtual Private Cloud). It is structured to support different environments and regions, with remote state management.

## Repository Structure

```
.
├── README.md
├── env
│   └── dev
│       └── us-west-2
│           ├── customer-01
│           │   ├── backend.tf
│           │   ├── main.tf
│           │   ├── terraform.tfvars
│           │   └── variables.tf
│           └── customer-02
│               ├── backend.tf
│               ├── main.tf
│               ├── terraform.tfvars
│               └── variables.tf
└── remote-backend-resource
    ├── main.tf
    ├── terraform.tfvars
    └── variables.tf

7 directories, 12 files
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS credentials configured using `aws configure` or environment variables
- Proper IAM permissions for managing AWS resources

## Setup & Usage

## This repo uses workflows extensively, and there is specific order of workflow execution. See below,
- for initializing & creating the remote backend : use `Provision Remote Backend` 
- for initializing & creating the VPC            : use `validate VPC`, this will auto-initiate the VPC creation after successful validation completion.
- for initializing & creating the EKS            : use `validate EKS`, this will auto-initiate the EKS creation after successful validation completion.
- for initializing & creating the Node Group     : use `validate Node Group`, this will auto-initiate the Node Group creation after successful validation completion.


## Remote State Management
The repository uses a remote backend for storing Terraform state. Ensure that the remote backend resources are created before running Terraform in individual environments.


## How to interact with the cluster
- Since this cluster (infra) is being created by assuming a role (named github-actions-role) by github workflow, our cli user (aws sts get-caller-identity) should also assume the same role by passing below command,

```
aws sts assume-role --role-arn arn:aws:iam::014337110715:role/github-actions-role  --role-session-name eks-session
``` 

- Once done, it will pop up a sccess key, secret access key and a token, export them into your cli and you are good to go. 
- Now update your local kubeconfig file to allow kubectl to communicate with the EKS cluster using below command,

```
aws eks update-kubeconfig --region us-west-2 --name terraform-aws-eks
```

## Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a pull request

## License
NA
