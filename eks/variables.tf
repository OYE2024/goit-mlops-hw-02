variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "aws_profile" {
  description = "AWS profile to use"
  type        = string
  default     = "oie-cli"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "mlops"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "goit"
}

variable "cluster_version" {
  description = "Kubernetes cluster version"
  type        = string
  default     = "1.31"
}

variable "cpu_node_group" {
  description = "CPU node group configuration"
  type = object({
    name           = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = number
  })
  default = {
    name           = "cpu-nodes"
    instance_types = ["t3.medium"]
    min_size       = 1
    max_size       = 3
    desired_size   = 2
    disk_size      = 50
  }
}

variable "workload_node_group" {
  description = "Workload/GPU node group configuration"
  type = object({
    name           = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = number
  })
  default = {
    name           = "workload-nodes"
    instance_types = ["t3.medium"]
    min_size       = 0
    max_size       = 2
    desired_size   = 1
    disk_size      = 50
  }
}

variable "enable_cluster_autoscaling" {
  description = "Enable cluster autoscaling"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "mlops"
    ManagedBy   = "terraform"
  }
}
