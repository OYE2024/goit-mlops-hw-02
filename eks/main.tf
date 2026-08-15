module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.project_name}-${var.environment}-eks"
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  manage_aws_auth_configmap = true

  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
    ami_type       = "AL2_x86_64"
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
  }

  eks_managed_node_groups = {
    cpu_nodes = {
      name           = var.cpu_node_group.name
      instance_types = var.cpu_node_group.instance_types

      min_size     = var.cpu_node_group.min_size
      max_size     = var.cpu_node_group.max_size
      desired_size = var.cpu_node_group.desired_size
      disk_size    = var.cpu_node_group.disk_size

      labels = {
        Environment = var.environment
        NodeGroup   = var.cpu_node_group.name
        Workload    = "cpu"
      }

      tags = {
        NodeGroup = var.cpu_node_group.name
      }
    }

    workload_nodes = {
      name           = var.workload_node_group.name
      instance_types = var.workload_node_group.instance_types

      min_size     = var.workload_node_group.min_size
      max_size     = var.workload_node_group.max_size
      desired_size = var.workload_node_group.desired_size
      disk_size    = var.workload_node_group.disk_size

      labels = {
        Environment = var.environment
        NodeGroup   = var.workload_node_group.name
        Workload    = "gpu"
      }

      taints = [{
        key    = "workload"
        value  = "gpu"
        effect = "NO_SCHEDULE"
      }]

      tags = {
        NodeGroup = var.workload_node_group.name
      }
    }
  }

  tags = var.tags
}
