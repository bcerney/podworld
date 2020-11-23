
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = "podworld-demo"


  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_ipv6          = false
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }

  tags = {
    User        = "terraform_user"
    Environment = "demo"
  }

  vpc_tags = {
    Name = "podworld-demo"
  }
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "13.2.1"

  cluster_name    = var.cluster_name
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    first = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity     = 2

      instance_type = "t3.micro"
    }
  }

  write_kubeconfig   = true
  config_output_path = "./"
}
