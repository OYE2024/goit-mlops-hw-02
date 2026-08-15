data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "mlops-tfstate-oie"
    key     = "vpc/terraform.tfstate"
    region  = "eu-west-1"
    profile = "oie-cli"
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}
