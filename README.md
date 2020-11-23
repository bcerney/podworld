# podworld
Terraform + EKS

# Install

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
terraform -help
terraform -install-autocomplete


https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
https://learnk8s.io/terraform-eks#provisioning-a-full-cluster-with-ingress-with-the-helm-provider
https://pafable.com/creating-a-kubernetes-cluster-using-eks/

sudo KUBECONFIG=./demo/kubeconfig_podworld-demo kubectl get pods
sudo KUBECONFIG=./demo/kubeconfig_podworld-demo kubectl apply -f deployment.yaml
sudo KUBECONFIG=./demo/kubeconfig_podworld-demo kubectl port-forward hello-kubernetes-7f65c7597f-kzpp8 8080:8080
