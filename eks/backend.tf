terraform {
  backend "s3" {
    bucket  = "mlops-tfstate-oie"
    key     = "eks/terraform.tfstate"
    region  = "eu-west-1"
    profile = "oie-cli"
    encrypt = true
  }
}
