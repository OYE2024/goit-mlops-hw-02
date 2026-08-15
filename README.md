# MLOps Lesson-5: AWS Infrastructure with Terraform

## Prerequisites
- AWS account with oie-cli profile configured
- terraform, aws-cli, kubectl installed

## Setup (one-time)
```bash
aws s3api create-bucket \
  --bucket mlops-tfstate-oie \
  --region eu-west-1 \
  --create-bucket-configuration LocationConstraint=eu-west-1 \
  --profile oie-cli

aws s3api put-bucket-versioning \
  --bucket mlops-tfstate-oie \
  --versioning-configuration Status=Enabled \
  --profile oie-cli
```

## Deploy Infrastructure
```bash
# VPC
cd vpc
terraform init
terraform plan
terraform apply

# EKS (after VPC deployment)
cd ../eks
terraform init
terraform plan
terraform apply
```

## Verify Deployment
```bash
# Get cluster credentials
aws eks update-kubeconfig --region eu-west-1 --name goit-mlops-eks --profile oie-cli

# Check nodes status
kubectl get nodes

# Check cluster info
kubectl cluster-info

# Check cluster info details
aws eks describe-cluster --name goit-mlops-eks --region eu-west-1 --profile oie-cli
```

## Destroy Infrastructure
```bash
# EKS first
cd eks
terraform destroy

# Then VPC
cd ../vpc
terraform destroy
```

## Infrastructure Details

| Component | Value |
|-----------|-------|
| Region | eu-west-1 |
| VPC CIDR | 10.0.0.0/16 |
| Public Subnets | 10.0.1-3.0/24 (3 AZs) |
| Private Subnets | 10.0.11-13.0/24 (3 AZs) |
| EKS Version | 1.30 |
| Node Groups | cpu-nodes (t3.medium), workload-nodes (t3.medium) |
| State Backend | S3: mlops-tfstate-oie |
