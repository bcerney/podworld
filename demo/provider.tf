provider "aws" {
  region                  = var.region
  shared_credentials_file = "/home/bgdgbc/.aws/credentials"
  profile                 = "terraform_user"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}